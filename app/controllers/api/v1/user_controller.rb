require 'csv'

module Api
	module V1
		class UserController < BaseController
			before_action :authenticate_api_user!, except: [:payment_confirmation, :payment_transaction]

			def tailor_announcements
				render json: Announcement.tailor_announcements(current_api_user), status: :ok
			end

			def funding_transaction
				@user = current_api_user

				@transaction = TransactionHistory.new(funding_transaction_params)
				@transaction.user_id = @user.id
				@transaction.transaction_type = "credit"

				if @transaction.save!
					@user.balance +=	 params[:amount].to_f
					@user.save!
					render json: {status: "ok"}, status: :ok
				else
					#TODO: develop markers
				end
			end

			def get_balance
				render json: {
						balance: current_api_user.balance,
						history: TransactionHistory.where(user_id: current_api_user.id).limit(4).order(created_at: :desc)
				}, status: :ok
			end

			def register_rfuid
				@user = current_api_user

				@user.rfuid = params[:rfuid]
				@user.rfuid_pin = params[:rfuid_pin]

				if @user.save!
					render json: {message: "RFID Registered, Welcome to CUPAY"}, status: :ok
				else
					render json: {message: "Error Registering RFID, Please try again..."}
				end
			end

			def payment_transaction
				@user = User.find_by(rfuid: params[:rfuid])

				if @user.rfuid_pin == params[:rfuid_pin]
					@transaction = TransactionHistory.new(
							amount: params[:amount],
							flw_ref: params[:flw_ref],
							tx_ref: params[:tx_ref],
							transaction_id: params[:transaction_id],
							transaction_title: params[:transaction_title],
							# transaction_details: params[:transaction_details]
					)
					@transaction.user_id = @user.id
					@transaction.transaction_type = "debit"

					if @user.balance > params[:amount].to_f
						if @transaction.save!
							@user.balance -=	 params[:amount].to_f
							@user.save!
							render json: {message: "Payment Successful"}, status: :ok
						else
							render json: {message: @transaction.errors}, status: :ok
						end
					else
						render json: {message: "Insufficient Funds"}, status: :ok
					end
				else
					render json: {message: "Wrong Pin, Please Try Again"}, status: :ok
				end
			end

			def payment_confirmation
				render json: {
						username: User.find_by(rfuid: params[:rfuid]).username,
						uid: User.find_by(rfuid: params[:rfuid]).uidm
				}
			end

			def toggle_card
				current_api_user.toggle!(:card_enabled)

				render json: {card_enabled: current_api_user.card_enabled}, status: :ok
			end

			private

				def register_rfid_params
					params.permit(:rfuid, :rfuid_pin)
				end

				def funding_transaction_params
					params.permit(:amount, :flw_ref, :tx_ref, :transaction_id, :transaction_title, :transaction_type)
				end

				def payment_transaction_params
					params.permit(:amount, :flw_ref, :tx_ref, :transaction_id, :transaction_title, :transaction_details, :rfuid, :rfuid_pin )
				end
		end
	end
end
