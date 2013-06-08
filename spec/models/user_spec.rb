require 'spec_helper'
describe User do
  describe ".new" do
    it "requires users to have email" do
      user = User.new(:email => nil)
      user.invalid?.should be_true
      user.errors[:email].should be_true
      expect(user.errors[:email].join).to eq('can\'t be blank')
    end
    it "requires users to have name" do
      user = User.new(:name => nil)
      user.invalid?.should be_true
      user.errors[:name].should be_true
      expect(user.errors[:name].join).to eq('can\'t be blank')
    end
    it "should be valid with required fields" do
      t = FactoryGirl.create(:ticket)

      user = User.new({
        :name => "Tester",
        :email => "me@mail.com",
        :tlf => "92043382",
        :password => "lala12345",
        :accepted_privacy => "1",
        :ticket_id => t.id,
        :company => "Smidig 2013"})
      user.valid?.should be_true
    end
    it "should require a ticket" do
      user = User.new({
        :name => "Tester",
        :email => "me@mail.com",
        :tlf => "92043382",
        :password => "lala12345",
        :accepted_privacy => "1",
        :company => "Smidig 2013"})
      user.valid?.should be_false
    end
    it "should require an active ticket" do
      t =
      user = User.new({
        :name => "Tester",
        :email => "me@mail.com",
        :tlf => "92043382",
        :password => "lala12345",
        :accepted_privacy => "1",
        :ticket_id =>  FactoryGirl.create(:ticket, active: false).id,
        :company => "Smidig 2013"})
      user.valid?.should be_false
    end

    it "should have a default after creation if no order was specified" do
      user = FactoryGirl.create(:user)

      user.order.should_not be_nil
      user.order.new_record?.should be_false
    end

    it "should have the still have the specified order after creation" do
      user = FactoryGirl.create(:user)
      another_user = FactoryGirl.create(:user, :order => user.order)

      another_user.order.should == user.order
    end
  end
end
