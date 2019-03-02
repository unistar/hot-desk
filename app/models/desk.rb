class Desk < ApplicationRecord
  validates :label, uniqueness: true
  has_many :bookings
  has_many :users, :through => :bookings
end
