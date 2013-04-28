class Ticket < ActiveRecord::Base
  attr_accessible :active, :name, :price, :visible
  validates_presence_of :name, :price

  has_many :users

  def self.default
    Ticket.find(:all, :conditions => { :visible => true, :active => true }).first
  end

  def self.visible
    Ticket.find(:all, :conditions => { :visible => true, :active => true })
  end

  def mva
    self.price - (self.price / 1.25)
  end

  def display
    name.to_s + " - (kr " + price.to_s + ",-)"
  end
end
