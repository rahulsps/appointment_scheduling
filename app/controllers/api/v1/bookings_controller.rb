module Api
	module V1
		class BookingsController < ApplicationController
			before_action :fetch_booking_times, only: [:available_tee_times, :booked_time_slots]
			before_action :total_time_slots, only: [:available_tee_times, :booked_time_slots]

			def create
				# we can create bookings through current user when we create a user session so we don't need user_id in params.
				booking = Booking.create!(booking_params)
				render json: { message: "Booking done succsefully"}
			end

			def available_tee_times
				calculate_booked_slots("available")
				available_tee_times = @total_time_slots.difference @booked_slots
				render json: { available_tee_times: available_tee_times}
			end

			def booked_time_slots
				calculate_booked_slots("booked")
				render json: { booked_slots: @booked_slots}
			end

			def cancel_booking
				begin
					booking = Booking.find_by_id(params[:id])
					if Date.today == booking.date
				    if booking.start_time.strftime("%H").to_i - Time.now.strftime("%H").to_i > 1
				    	booking.destroy!
				    else
	            raise "You cannot cancel the booking now"
				    end 
					else
					  booking.destroy!
				  end
					render json: { message: "Booking cancelled succsefully"}
				rescue StandardError => e
					render json: { message: e.message }, status: 401
				end
			end

			private

			def booking_params
				params.require(:booking).permit(:user_id, :start_time, :end_time, :date)
			end

			def fetch_booking_times
				@booking_times = Booking.where(date: params[:date]).pluck(:start_time, :end_time)
			end

			def total_time_slots
				@total_time_slots = ["08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00"]
			end


			def calculate_booked_slots(value)
				@booked_slots = []
				@booking_times.each do |i|
          @total_time_slots.each do |j|
          	if value == "booked"
							if (i[0].strftime("%H:%M")..(i[1]).strftime("%H:%M")).cover? j
								@booked_slots << j
						  end
						else
							if (i[0].strftime("%H:%M")..(i[1] - 1).strftime("%H:%M")).cover? j
								@booked_slots << j
						  end
						end
					end
				end
				@booked_slots
			end
    end
  end
end
