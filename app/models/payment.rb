class Payment < ActiveRecord::Base
  belongs_to :order
  attr_accessible :order_id
  after_create :set_invoice_id
  default_scope order('created_at DESC')
  # Abstract interface for payments, implementations:
  #  - PaypalPayment
  #  - ManualPayment

  #attr_accessible :completed, :completed_at, :manual_company_email, :manual_company_name, :manual_contact_person, :manual_invoice_sent, :manual_post_code, :manual_street_address, :paid_amount, :paypal_currency, :paypal_params, :paypal_payer_email, :paypal_status, :paypal_tx_id, :paypal_tx_type, :price, :order_id

  def set_invoice_id
    time = Time.new.strftime("%Y%m%d")
    if Rails.env == "production"
      self.invoice_id = "#{time}p#{id}"
    else
      self.invoice_id = "#{time}t#{id}"
    end
    save!
  end

  def finish
    transaction do
      self.completed_at = Time.now
      self.completed = true
      order.finish
      save!
    end
  end
end
