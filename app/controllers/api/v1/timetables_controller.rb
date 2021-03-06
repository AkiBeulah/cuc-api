require 'csv'

module Api
	module V1
		class TimetablesController < ApplicationController
			before_action :set_timetable, only: [:show, :update, :destroy]

			# GET /timetables
			# GET /timetables.json
			def index
				render json: Timetable.all, status: :ok
			end

			# GET /timetables/1
			# GET /timetables/1.json
			def filter
				render json: Timetable.where(day: params[:day], level: params[:level]), status: :ok
			end

			# POST /timetables
			# POST /timetables.json
			def create
				@timetable = Timetable.new(timetable_params)

				if @timetable.save!
					render json: @timetable, status: :created
				else
					render json: @timetable.errors, status: :unprocessable_entity
				end
			end

			def bulk_create
				counter = []

				params[:csv].each do |csv|
					timetable_name = csv.original_filename
					timetable_headers = CSV.read(csv, :headers => true).headers
					CSV.foreach(csv, headers: true) do |row|
						(2..13).each { |i|
							if row[i]
								if Course.find_by(course_code: row[i][0,6].downcase)
									@course = Course.find_by(course_code: row[i][0,6].downcase)
								else
									@course = Course.new(course_code: row[i][0,6].downcase!)

									if @course.save!(validate: false)
										counter.push({
																		 course_code: row[i],
																		 errors: "Course does not exist and has been blank registered. Will need update"
																 })
									end
								end

								@timetable = {
										course_code: row[i][0,6].downcase!,
										building: row[0],
										venue: row[1],
										time: timetable_headers[i],
										day: timetable_name[0, timetable_name.index("_")],
										session: timetable_name[timetable_name.index("_") + 1],
										level: row[i][3, 1].to_i * 100
								}
								authorize @course
								unless @course.timetables.create(@timetable)
									counter.push({
																	 course_code: row[1],
																	 building: row[0],
																	 venue: row[1],
																	 time: timetable_headers[i],
																	 day: timetable_name[0, timetable_name.index("_")],
																	 errors: @timetable.errors
															 })
								end
							end
						}
					end
				end

				if counter.empty?
					render json: Timetable.all, status: :created
				else
					render json: {message: "There were some errors...", errors: counter}, status: :ok
				end
			end

			# PATCH/PUT /timetables/1
			# PATCH/PUT /timetables/1.json
			def update
				if @timetable.update(timetable_params)
					render :show, status: :ok, location: @timetable
				else
					render json: @timetable.errors, status: :unprocessable_entity
				end
			end

			# DELETE /timetables/1
			# DELETE /timetables/1.json
			def destroy
				@timetable.destroy
			end

			private

			# Use callbacks to share common setup or constraints between actions.
			def set_timetable
				@timetable = Timetable.find(params[:id])
			end

			# Only allow a list of trusted parameters through.
			def timetable_params
				params.require(:timetable).permit(:course_code, :building, :venue, :time, :day, :session)
			end

			def timetable_csv_param
				param.require(:timetable).permit(:csv)
			end

			def timetable_filter_params
				params.require(:timetable).permit(:day, :level)
			end
		end
	end
end