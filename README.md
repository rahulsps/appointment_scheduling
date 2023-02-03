# Appointment Scheduling Application

This project contains APIs to handle the golf course booking and cancellation. 

Steps to setup the project. Please run these commands:

1. Bundle install
2. rails db:create
3. rails db:migrate

Run app server with command: 

* rails s


Few considerations: 

* Time is considered in a 24 hours format.
* A golfer can book a slot in a minimum time frame of 30 minutes. So the slots between 8am - 4pm are divided in 30 minutes.

Insights about the APIs:

Users controller
================

1. create - This API will create the user with a name and will return the user in response.

2. find_bookings - This API will find the bookings of a golfer by his/her name.

Bookings Controller
===================

1. create - This API will create a booking for a golfer for the given date.

2. available_tee_times - This API will share the list of availale tee times for the given date.

3. booked_time_slots - This API will share the list of booked time slots for the given date.

4. cancel_booking - This API will cance the booking of a golfer for the given date.

Export the Appointment_Scheduling.postman_collection.json file from root folder in your postman app for APIs collection and example.
