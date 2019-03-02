class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :desk
  before_save :date_ordered?

  private
    
    def date_ordered?
      self.begin_date <= self.end_date
    end
end
