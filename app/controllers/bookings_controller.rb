class BookingsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @bookings = @user&.bookings
  end

  def new
    @user = User.find(params[:user_id])
    @desks = Desk.all
    @booking = @user.bookings.build
  end

  def create
    @user = User.find(params[:user_id])
    @desks = Desk.all
    @desk = Desk.find(params[:booking][:desk_id])
    if @user.cross_check_hit(booking_params) || @desk.cross_check_hit(booking_params)
      @booking = @user.bookings.build(booking_params)
      render 'new'
      return
    end
    @booking = @user.bookings.build(booking_params)
    if @booking.save
      redirect_to user_bookings_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @desks = Desk.all
    @booking = Booking.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @desks = Desk.all
    @booking = Booking.find(params[:id])
    @desk = Desk.find(params[:booking][:desk_id])
    if @user.cross_check_hit(booking_params, @booking&.id) || @desk.cross_check_hit(booking_params, @booking&.id)
      render 'edit'
      return
    end
    if @booking.update(booking_params)
      redirect_to user_bookings_url
    else
      render 'edit'
    end
  end

  def destroy
    Booking.find(params[:id]).destroy
    redirect_to user_bookings_url
  end

  private
    def booking_params
      begin_date = {begin_date: Date.new(params[:booking]["begin_date(1i)"].to_i, params[:booking]["begin_date(2i)"].to_i, params[:booking]["begin_date(3i)"].to_i)}
      end_date = {end_date: Date.new(params[:booking]["end_date(1i)"].to_i, params[:booking]["end_date(2i)"].to_i, params[:booking]["end_date(3i)"].to_i)}
      {user_id: params[:user_id].to_i}.merge(begin_date).merge(end_date).merge({desk_id: params[:booking][:desk_id].to_i})
    end
end
