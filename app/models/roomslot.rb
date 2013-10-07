class Roomslot < ActiveRecord::Base
  attr_accessible :room_id, :timeslot_id, :talk_ids, :title, :description
  belongs_to :timeslot
  belongs_to :room
  has_many :talks, :order => 'roomslot_priority ASC'

  default_scope :joins => :room, :order => 'rooms.name'

  def max_priority 
    if talks.size > 0
      return talks.last.roomslot_priority
    end
    0
  end
end
