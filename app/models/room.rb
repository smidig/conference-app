class Room < ActiveRecord::Base
  attr_accessible :details, :name, :color, :priority, :size
  has_many :roomslot
  default_scope :order => 'priority DESC'

  def talk_count
    self.roomslot.includes(:talks).map(&:talks).map(&:count).sum
  end

  def can_delete?
    self.talk_count == 0
  end
end
