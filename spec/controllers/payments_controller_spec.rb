require 'spec_helper'

describe PaymentsController do

  describe "GET 'index'" do
    it "returns http success for admin user" do
      user = FactoryGirl.create(:user)
      user.admin = true
      user.save!
      sign_in user

      get 'index'

      expect(response.code).to eq("200")
    end

    it "returns redirect to sign_up for non admin user" do
      sign_in FactoryGirl.create(:user)

      get 'index'
      expect(response.code).to eq("302")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @payment = PaypalPayment.create!
    end
    it "returns http success for admin user" do
      sign_in admin_user
      get 'show', {:id => @payment.id}
      expect(response.code).to eq("200")
    end

    it "returns redirect to sign_up for non admin user" do
      sign_in FactoryGirl.create(:user)
      get 'show', {:id => @payment.id}
      expect(response.code).to eq("302")
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

   describe "GET 'new_manual'" do
    it "should not create new manual" do
      user = admin_user()
      sign_in user
      order = FactoryGirl.create(:order, owner_user_id: user.id)
      expect {get :new_manual, {:order_id => order.id}}.to change(Payment, :count).by(0)
    end
    it "should allow order.owner to get new_manual template" do
      user = FactoryGirl.create(:user)
      sign_in user
      order = FactoryGirl.create(:order, owner_user_id: user.id)
      get 'new_manual', {:order_id => order.id}
      expect(response.code).to eq("200")
      expect(response).to render_template("new_manual")
    end
    it "should not allow others (not order.owner) to get new_manual template" do
      user = FactoryGirl.create(:user)
      sign_in user
      order = create_order_for(FactoryGirl.create(:user))
      get 'new_manual', {:order_id => order.id}
      expect(response.code).to eq("302")
    end
    it "should redirect if order already has payment" do
      user = FactoryGirl.create(:user)
      sign_in user
      order = FactoryGirl.create(:order, owner_user_id: user.id)
      payment = ManualPayment.create({
        :manual_company_name => 'company',
        :manual_contact_person => 'Ola',
        :manual_company_email => 'me@email.com',
        :order_id => order.id})

      get 'new_manual', {:order_id => order.id}
      expect(response.code).to eq("302")
    end
  end

  describe "POST 'create_manual'" do
    it "should create new ManualPayment for admin user" do
      user = admin_user()
      sign_in user
      order = create_order_for(FactoryGirl.create(:user))

      expect {post :create_manual, {:manual_payment => {
        :manual_company_name => 'company',
        :manual_contact_person => 'Ola',
        :manual_company_email => 'me@email.com',
        :order_id => order.id}}}.to change(Payment, :count).by(1)
    end
    it "should create new ManualPayment for user which owns the order" do
      user = FactoryGirl.create(:user)
      sign_in user
      order = FactoryGirl.create(:order, owner_user_id: user.id)

      expect {post :create_manual, {:manual_payment => {
        :manual_company_name => 'company',
        :manual_contact_person => 'Ola',
        :manual_company_email => 'me@email.com',
        :order_id => order.id}}}.to change(Payment, :count).by(1)
    end
    it "should not create new ManualPayment for other user (not order.owner)" do
      user = FactoryGirl.create(:user)
      sign_in user
      order = create_order_for(FactoryGirl.create(:user))

      expect {post :create_manual, {:manual_payment => {
        :manual_company_name => 'company',
        :manual_contact_person => 'Ola',
        :manual_company_email => 'me@email.com',
        :order_id => order.id}}}.to change(Payment, :count).by(0)
    end

  end

  def admin_user
    FactoryGirl.create(:admin)
  end

  def create_order_for(user)
    FactoryGirl.create(:order, owner_user_id: user.id)
  end


end
