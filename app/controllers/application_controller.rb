class ApplicationController < ActionController::API
	include Pundit
	include DeviseTokenAuth::Concerns::SetUserByToken
	# protect_from_forgery with: :null_session
	before_action :authenticate_api_user!, only: [:bulk_create, :update, :destroy]
	before_action :configure_permitted_parameters, if: :devise_controller?
	skip_before_action :authenticate_api_user!, if: :devise_controller?, only: :create
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	respond_to :json

	def user_not_authorized
		render json: {message: "You do not have the permission to access this endpoint"}, status: :unauthorized
	end

	protected

		def pundit_user
			current_api_user
		end

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :level, :college, :department, :program, :option, :hall])
		end
end
