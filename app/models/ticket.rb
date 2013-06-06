class Ticket < ActiveRecord::Base
  attr_accessible :active, :name, :price, :visible, :ticket_type
  has_many :users

  TICKET_TYPES = %w(free speaker regular)

  validates_presence_of :name, :price
  validates :ticket_type, :inclusion => {:in => TICKET_TYPES}, :allow_nil => true

  def self.default
    Ticket.find(:all, :conditions => { :visible => true, :active => true }).first
  end

  def self.visible
    Ticket.find(:all, :conditions => { :visible => true, :active => true })
  end

  def mva
    self.price - (self.price / 1.25)
  end

  def price_ex_mva
    self.price / 1.25
  end

  def display
    name.to_s + " - (kr " + price.to_s + ",-)"
  end
end
