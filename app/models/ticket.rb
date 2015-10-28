class Ticket < ActiveRecord::Base
  attr_accessible :active, :name, :price, :visible, :ticket_type, :printflag, :printname
  has_many :users

  TICKET_TYPES = %w(free speaker regular)

  validates_presence_of :name, :price
  validates :ticket_type, :inclusion => {:in => TICKET_TYPES}

  def self.default
    visible.first
  end

  def self.visible
    Ticket.find(:all, :conditions => { :visible => true, :active => true }, :order => "price asc")
  end

  def mva
    price - price_ex_mva
  end

  def price_ex_mva
    price / 1.25
  end

  def display
    name.to_s + " - (kr " + price.to_s + ",-)"
  end

  def self.toggle_early_bird(early_bird_available)
    eb = self.where( :name => 'Early Bird 2015').first
    reg = self.where( :name => 'Regular 2015').first

    if early_bird_available
      eb.active = true
      eb.visible = true
      reg.active = false
      reg.visible = false
    else
      eb.active = false
      eb.visible = false
      reg.active = true
      reg.visible = true
    end

    eb.save
    reg.save
  end
end
