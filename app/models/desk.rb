class Desk < ApplicationRecord
  validates :label, uniqueness: true
  has_many :bookings
  has_many :users, :through => :bookings

  def cross_check_hit(params, to_update = 0)
    current_booking = []
    if to_update > 0
      current_booking << Booking.find(to_update)
    end
    items_to_check = bookings - [current_booking]
    items_to_check.any? {|b| (params[:begin_date] >= b.begin_date && params[:begin_date] <= b.end_date) ||
                       (params[:end_date] <= b.end_date && params[:end_date] >= b.begin_date)}
  end
end
