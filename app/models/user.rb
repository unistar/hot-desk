class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false } 
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :bookings
  has_many :desks, :through => :bookings

  def cross_check_hit(params)
    bookings.any? {|b| (params[:begin_date] >= b.begin_date && params[:begin_date] <= b.end_date) || 
		       (params[:end_date] <= b.end_date && params[:end_date] >= b.begin_date)}
  end
 
  def active_bookings
    bookings.select {|booking| booking.end_date >= Date.today }
  end
end

