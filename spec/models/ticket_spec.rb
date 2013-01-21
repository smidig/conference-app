require 'spec_helper'

describe Ticket do
  describe ".new" do
    it "should require a name" do
      ticket = Ticket.new(:name => nil)
      ticket.invalid?.should be_true
      ticket.errors[:name].should be_true
    end
    it "should require a price" do
      ticket = Ticket.new(:price => nil)
      ticket.invalid?.should be_true
      ticket.errors[:price].should be_true
    end
    it "should create new instance" do
      ticket = Ticket.new(:price=>3000, :name=>"Early Bird")
      ticket.save!
      ticket.valid?.should be_true
      Ticket.find(ticket.id).should eq(ticket)
    end
  end
end
