require 'spec_helper'

describe PaymentsController do

  describe "GET 'index'" do
    it "returns http success for admin user" do
      user = FactoryGirl.create(:user)
      user.admin = true
      user.save!
      sign_in user

      get 'index'

      response.should be_success
    end

    it "returns redirect to sign_up for non admin user" do
      sign_in FactoryGirl.create(:user)

      get 'index'
      response.should be_redirect
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @payment = PaypalPayment.create!
    end
    it "returns http success for admin user" do
      sign_in admin_user
      get 'show', {:id => @payment.id}
      response.should be_success
    end

    it "returns redirect to sign_up for non admin user" do
      sign_in FactoryGirl.create(:user)
      get 'show', {:id => @payment.id}
      response.should be_redirect
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @payment = PaypalPayment.create!
    end
    it "should delete if admin user" do
      sign_in admin_user
      expect {delete :destroy, {:id => @payment.id}}.to change(Payment, :count).by(-1)
    end
    it "should not delete if user is not admin" do
      sign_in FactoryGirl.create(:user)
      expect {delete :destroy, {:id => @payment.id}}.to_not change(Payment, :count)
    end
  end

  describe "GET 'new_paypal'" do
    it "should create new payment if order does not have a payment" do
      sign_in admin_user
      order = FactoryGirl.create(:order)
      order.owner_user_id = admin_user.id
      order.save!
      expect {get :new_paypal, {:order_id => order.id}}.to change(Payment, :count).by(1)
    end
    it "should not create new payment if order has a payment" do
      sign_in admin_user
      order = FactoryGirl.create(:order)
      order.payment = PaypalPayment.create!
      expect {get :new_paypal, {:order_id => order.id}}.to change(Payment, :count).by(0)
    end
    it "should not create new payment if user does not own the order" do
      sign_in FactoryGirl.create(:user)
      order = FactoryGirl.create(:order)
      order.owner_user_id = FactoryGirl.create(:user).id
      expect {get :new_paypal, {:order_id => order.id}}.to change(Payment, :count).by(0)
    end
    it "should create new payment if order does not have a payment and user is admin" do
      sign_in admin_user
      order = FactoryGirl.create(:order)
      order.owner_user_id = FactoryGirl.create(:user).id
      order.save!
      expect {get :new_paypal, {:order_id => order.id}}.to change(Payment, :count).by(1)
    end
  end




  def admin_user
    user = FactoryGirl.create(:user)
    user.admin = true
    user.save!
    return user
  end


end
