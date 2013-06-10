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

    context "when associated with a ticket of type 'regular'" do
      it "should have a default order after creation if no order was specified" do
        user = FactoryGirl.create(:user)

        user.order.should_not be_nil
        user.order.new_record?.should be_false
      end

      it "should have the still have the specified order after creation" do
        user = FactoryGirl.create(:user)
        another_user = FactoryGirl.create(:user, :order => user.order)

        another_user.order.should == user.order
      end

      it "upon changing the ticket to one of type other than 'regular', should not have an order" do
        free_ticket = FactoryGirl.create(:free_ticket)
        user = FactoryGirl.create(:user)
        user.ticket = free_ticket
        user.save

        expect {
          user.order.reload
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when associated with a ticket of type other than 'regular'" do
      it "should not have a default order after creation if no order was specified" do
        user = FactoryGirl.create(:user, :ticket => FactoryGirl.create(:free_ticket))

        user.order.should be_nil
      end

      it "should have the still have the specified order after creation" do
        user = FactoryGirl.create(:user)
        another_user = FactoryGirl.create(:user, :order => user.order)

        another_user.order.should == user.order
      end

      it "upon changing the ticket to one of type 'regular', should have a default order after creation if no order was specified" do
        regular_ticket = FactoryGirl.create(:ticket)
        user = FactoryGirl.create(:user, :ticket => FactoryGirl.create(:free_ticket))
        user.ticket = regular_ticket
        user.save

        user.order.should_not be_nil
      end
    end
  end
end
