class Timeslot < ActiveRecord::Base
  attr_accessible :end, :start
  has_many :roomslot
  default_scope order('start ASC')
end
