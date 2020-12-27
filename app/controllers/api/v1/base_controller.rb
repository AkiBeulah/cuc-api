module Api
	module V1
		class BaseController < ApplicationController

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

			private

				def query_params
					params.permit(:query)
				end
		end
	end
end