# == Schema Information
#
# Table name: payments
#
#  id                    :integer          not null, primary key
#  price                 :integer
#  paid_amount           :integer
#  completed             :boolean
#  completed_at          :datetime
#  paypal_params         :text
#  paypal_tx_id          :string(255)
#  paypal_tx_type        :string(255)
#  paypal_currency       :string(255)
#  paypal_status         :string(255)
#  paypal_payer_email    :string(255)
#  manual_company_name   :string(255)
#  manual_company_email  :string(255)
#  manual_contact_person :string(255)
#  manual_street_address :string(255)
#  manual_post_code      :string(255)
#  manual_invoice_sent   :boolean
#  order_id              :integer
#  type                  :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  invoice_id            :string(255)
#

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
    time = Time.new
    payment.invoice_id.should eq("#{time.year}t#{payment.id}")
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
