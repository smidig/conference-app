class Timeslot < ActiveRecord::Base
  attr_accessible :end, :start, :is_workshop_slot
  has_many :roomslot
  default_scope order('start ASC, end ASC')

end
