class Room < ActiveRecord::Base
  attr_accessible :details, :name
  has_many :roomslot
end
