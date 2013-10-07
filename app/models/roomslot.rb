class Roomslot < ActiveRecord::Base
  attr_accessible :room_id, :timeslot_id, :talk_ids, :title, :description
  belongs_to :timeslot
  belongs_to :room
  has_many :talks

  default_scope :joins => :room, :order => 'rooms.name'
end
