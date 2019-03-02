class BookingsController < ApplicationController
  def index
    @bookings = current_user&.bookings
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to user_bookings_url
    else
      render 'new'
    end
  end

  def update
  end
end
