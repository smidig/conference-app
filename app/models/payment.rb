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

class Payment < ActiveRecord::Base
  belongs_to :order
  attr_accessible :order_id
  after_create :set_invoice_id
  # Abstract interface for payments, implementations:
  #  - PaypalPayment
  #  - ManualPayment

  #attr_accessible :completed, :completed_at, :manual_company_email, :manual_company_name, :manual_contact_person, :manual_invoice_sent, :manual_post_code, :manual_street_address, :paid_amount, :paypal_currency, :paypal_params, :paypal_payer_email, :paypal_status, :paypal_tx_id, :paypal_tx_type, :price, :order_id

  def set_invoice_id
    time = Time.new
    if Rails.env == "production"
      self.invoice_id = "#{time.year}#{id}"
    else
      self.invoice_id = "#{time.year}t#{id}"
    end
    self.save!
  end

  def finish
    self.transaction do
      self.completed_at = Time.now
      self.completed = true
      self.order.finish
      self.save!
    end
  end
end
