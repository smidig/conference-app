require 'spec_helper'

describe Order do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @user.ticket = Ticket.new({:name => "name", :price => 200})
    @user2.ticket = Ticket.new({:name => "name", :price => 300})
  end
  it "should be possible to create order" do

    order = Order.new({
        :completed => false,
        :owner_user_id => @user.id
      })

    order.save!
    @user.order_id = order.id
    @user.save!

    order.users.size.should == 1
    order.users.first.id.should == @user.id
    order.owner_user_id.should == @user.id
  end
  it "should sum prices based on users tickets" do

    order = Order.new({
        :completed => false,
        :owner_user_id => @user.id
      })

    order.save!
    @user.order_id = order.id
    @user2.order_id = order.id
    @user.save!
    @user2.save!

    order.price.should == 500
  end
end
