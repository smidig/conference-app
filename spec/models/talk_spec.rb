require 'spec_helper'

describe Talk do
  describe ".new" do
    it "should require a title" do
      talk = Talk.new(:title => nil)
      talk.errors[:name].should be_true
    end
    it "should require a description" do
      talk = Talk.new(:description => nil)
      talk.errors[:description].should be_true
    end
    it "should be valid with required fields" do
      talk = FactoryGirl.create(:talk)
      talk.valid?.should be_true
    end
  end
end
