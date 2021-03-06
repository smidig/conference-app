require 'spec_helper'

describe Order do
  before(:each) do
    @user = FactoryGirl.create(:user, ticket: FactoryGirl.create(:ticket, price: 200))
    @user2 = FactoryGirl.create(:user, ticket: FactoryGirl.create(:ticket, price: 300))
  end
  it "should be possible to create order" do

    order = Order.new({
        :completed => false,
        :owner => @user
      })

    order.save!
    @user.order = order
    @user.save!

    order.users.size.should == 1
    order.users.first.id.should == @user.id
    order.owner_user_id.should == @user.id
    order.owner.should == @user
  end
  it "should sum prices based on users tickets" do

    order = Order.new({
        :completed => false,
        :owner => @user
      })

    order.save!
    @user.order = order
    @user2.order = order
    @user.save!
    @user2.save!

    order.price.should == 500
  end
   it "should complete all users" do

    order = Order.new({
        :completed => false,
        :owner => @user
      })

    order.save!

    @user.order = order
    @user2.order = order

    @user.save!
    @user2.save!

    order.finish

    @user.reload
    @user2.reload

    @user.completed.should be_true
    @user2.completed.should be_true
    order.completed.should be_true
  end
end
