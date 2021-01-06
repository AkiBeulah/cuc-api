module Api
	module V1
		class BaseController < ApplicationController
			before_action :authenticate_api_user!, only: %i[student_enroll status]

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
				params[:courses].each do |course|
					current_api_user.courses << Course.find_by(course_code: course.upcase)
				end

				render json: current_api_user.courses, status: :created
			end

			def check_status
				render json: {status: 'logged in'}, status: :ok
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
