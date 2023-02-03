module Api
  module V1
		class UsersController < ApplicationController
			def create
				@user = User.create!(user_params)
			  render json: { user: @user }
			end

			def find_bookings
				user = User.find_by_name(params[:name])
				bookings = user.bookings
				render json: { bookings: bookings }
			end

			private

			def user_params
				params.require(:user).permit(:name)
			end
    end
	end
end
