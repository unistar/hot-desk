class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :desk
  validates :user_id, :uniqueness => { :scope => [:begin_date, :end_date], :message => "should book one seat in a given time" }
  validate :date_ordered?, :date_valid?

    
  def date_ordered?
    if begin_date > end_date
      errors.add(:begin_date, "cannot be in front of end date")
    end
  end

  def date_valid?
    if begin_date < Date.today
      errors.add(:begin_date, "cannot be in the past") 
    end
  end

  def in_valid?
    end_date >= Date.today
  end
end
