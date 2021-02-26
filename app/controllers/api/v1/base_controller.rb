module Api
	module V1
		class BaseController < ApplicationController
			before_action :authenticate_api_user!, only: %i[student_enroll check_status personal_timetable]

			def query
				@timetable = Timetable.search(params[:query])
				@ann = Announcement.search(params[:query])
				@course = Course.search(params[:query])

				render json: {
						timetable: @timetable,
						courses: @course,
						announcements: @ann
				}, status: :ok
			end

			def search_courses
				@course = Course.search(params[:query])

				render json: { course: @course }, status: :ok
			end

			def student_enroll
				params[:courses].each do |course|
					current_api_user.courses << Course.find_by(course_code: course.downcase)
				end

				render json: current_api_user.courses, status: :created
			end

			def check_status
				render json: {status: "ok"}, status: :ok
			end

			def get_schedule
				render json: current_api_user.schedule, status: :ok
			end				

			private

				def query_params
					params.permit(:query)
				end

				def search_courses_params
					params.permit(:query)
				end

				def enroll_params
					params.permit(:courses)
				end
		end
	end
end
