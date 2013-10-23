class Roomslot < ActiveRecord::Base
  attr_accessible :room_id, :timeslot_id, :talk_ids, :title, :description
  belongs_to :timeslot
  belongs_to :room
  has_many :talks, :order => 'roomslot_priority ASC'

  default_scope :joins => :room, :order => 'rooms.priority DESC'

  after_destroy :cleanup_talks

  def max_priority 
    if talks.size > 0
      return talks.last.roomslot_priority
    end
    0
  end

  private
  def cleanup_talks
    talks.each do |talk|
      talk.roomslot = nil
      talk.roomslot_priority = 0
      talk.save
    end
  end
end
