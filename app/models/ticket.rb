class Ticket < ActiveRecord::Base
  attr_accessible :active, :name, :price, :visible
  validates_presence_of :name, :price

  has_many :users
end
