module Api
	module V1
		class BaseController < ApplicationController
			before_action :authenticate_api_user!, only: %i[student_enroll]

			def query
				@timetable = Timetable.search(params[:query])
				@course = Course.search(params[:query])
				@ann = Announcement.search(params[:query])

				render json: {
						timetable: @timetable,
						courses: @course,
						announcements: @ann
				}, status: :ok
			end

			def student_enroll
				errors = []
				params[:courses].each do |course|
					@enrollment = CourseEnrollment.new(
							user_id: current_api_user.id,
							course_id: Course.find_by(course_code: course)
					)

					unless @enrollment.save!
						errors.push(@enrollment.errors)
					end
				end

				if errors.empty?
					render json: current_api_user.course_enrollements, status: :created
				else
					render json: {message: "There were some errors...", errors: errors}, status: :ok
				end
			end

			private

				def query_params
					params.permit(:query)
				end

				def enroll_params
					params.permit(:courses)
				end
		end
	end
end