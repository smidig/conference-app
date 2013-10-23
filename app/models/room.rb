class Room < ActiveRecord::Base
  attr_accessible :details, :name, :color, :priority
  has_many :roomslot
  default_scope :order => 'priority DESC'
end
