require 'spec_helper'

describe Payment do
  before(:each) do
    @order = FactoryGirl.create(:order)
  end

  it "should be possible to create paypal payment for order" do
    payment = PaypalPayment.new({
        :price => @order.price,
        :order_id => @order.id
      })
    payment.save!
    @order.payment.should eq(payment)
    @order.payment.class.should eq(PaypalPayment)
  end

  it "should be possible to manual payment for order" do
    payment = ManualPayment.new({
        :price => @order.price,
        :order_id => @order.id
      })
    payment.save!
    @order.payment.should eq(payment)
  end

  it "should generate and set invoice_id after create" do
    payment = ManualPayment.new({
        :price => @order.price,
        :order_id => @order.id
      })
    payment.save!
    time = Time.new
    payment.invoice_id.should eq("#{time.year}t#{payment.id}")
  end
end
