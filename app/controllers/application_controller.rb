class ApplicationController < ActionController::API
	include Pundit
	include DeviseTokenAuth::Concerns::SetUserByToken
	# protect_from_forgery with: :null_session
	before_action :authenticate_api_user!, only: [:bulk_create, :update, :destroy]
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	respond_to :json

	def user_not_authorized
		render json: {message: "You do not have the permission to access this endpoint"}, status: :unauthorized
	end

	protected

		def pundit_user
			current_api_user
		end
end
