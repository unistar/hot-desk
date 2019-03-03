class Desk < ApplicationRecord
  validates :label, uniqueness: true
  has_many :bookings
  has_many :users, :through => :bookings

  def cross_check_hit(params)
    bookings.any? {|b| (params[:begin_date] >= b.begin_date && params[:begin_date] <= b.end_date) ||
                       (params[:end_date] <= b.end_date && params[:end_date] >= b.begin_date)}
  end
end
