class Room < ActiveRecord::Base
  attr_accessible :details, :name, :color, :priority, :size
  has_many :roomslot
  default_scope :order => 'priority DESC'
end
