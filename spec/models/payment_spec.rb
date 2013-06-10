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
        :order_id => @order.id,
        :manual_company_name=> 'company',
        :manual_contact_person => 'Ola',
        :manual_company_email => 'me@email.com'
      })
    payment.save!
    @order.payment.should eq(payment)
  end

  it "should generate and set invoice_id after create" do
    payment = ManualPayment.new({
        :price => @order.price,
        :order_id => @order.id,
        :manual_company_name=> 'company',
        :manual_contact_person => 'Ola',
        :manual_company_email => 'me@email.com'
      })
    payment.save!
    time = Time.new.strftime("%Y%m%d")
    payment.invoice_id.should eq("#{time}t#{payment.id}")
  end

  it "should finish payment" do
    payment = PaypalPayment.new({
        :price => @order.price,
        :order_id => @order.id
      })
    payment.save!

    payment.finish
    @order.reload

    payment.completed.should be_true
    @order.completed.should be_true
  end
end
