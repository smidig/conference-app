class Timeslot < ActiveRecord::Base
  attr_accessible :end, :start, :is_workshop_slot
  has_many :roomslot
  default_scope order('timeslots.start ASC, timeslots.end ASC')

  def description
    "#{self.start} - #{self.end} - #{self.is_workshop_slot? ? 'Workshop' : 'Not Workshop'}"
  end
end
