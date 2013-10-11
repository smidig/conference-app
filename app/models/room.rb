class Room < ActiveRecord::Base
  attr_accessible :details, :name, :color
  has_many :roomslot
end
