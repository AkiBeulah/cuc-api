require 'csv'

module Api
	module V1
		class CoursesController < BaseController
			before_action :set_course, only: [:show, :update, :destroy]

			# GET /courses
			# GET /courses.json
			def index
				@courses = Course.all
			end

			# GET /courses/1
			# GET /courses/1.json
			def show
			end

			# POST /courses
			# POST /courses.json
			def create
				@course = Course.new(course_params)

				if @course.save
					render json: @course, status: :created
				else
					render json: @course.errors, status: :unprocessable_entity
				end
			end

			def bulk_create
				counter = []

				params[:csv].each do |csv|
					CSV.foreach(csv, headers: true, encoding: 'iso-8859-1:utf-8') do |row|
						if row[0]
							@course = Course.new(
									course_code: row[1],
									course_description: row[7],
									course_grouping: row[0],
									course_unit: row[4],
									course_title: row[2],
									course_unit_temp: 0,
									status: row[3],
									semester: row[6],
									prerequisite: row[5]
							)

							authorize @course
							unless @course.save!
								counter.push({
																 course_code: row[1],
																 errors: @course.errors
														 })
							end
						end
					end
				end

				if counter.empty?
					render json: Course.all, status: :created
				else
					render json: {message: "There were some errors...", errors: counter}, status: :ok
				end
			end

			# PATCH/PUT /courses/1
			# PATCH/PUT /courses/1.json
			def update
				if @course.update(course_params)
					render :show, status: :ok, location: @course
				else
					render json: @course.errors, status: :unprocessable_entity
				end
			end

			# DELETE /courses/1
			# DELETE /courses/1.json
			def destroy
				@course.destroy
			end

			private

			# Use callbacks to share common setup or constraints between actions.
			def set_course
				@course = Course.find(params[:id])
			end

			# Only allow a list of trusted parameters through.
			def course_params
				params.require(:course).permit(:course_code, :course_description, :course_unit, :course_unit_temp, :status, :semester)
			end

			def course_csv_params
				params.require(:course).permit(:csv)
			end
		end

	end
end