class Payment < ActiveRecord::Base
  belongs_to :order
  attr_accessible :order_id
  # Abstract interface for payments, implementations:
  #  - PaypalPayment
  #  - ManualPayment

  #attr_accessible :completed, :completed_at, :manual_company_email, :manual_company_name, :manual_contact_person, :manual_invoice_sent, :manual_post_code, :manual_street_address, :paid_amount, :paypal_currency, :paypal_params, :paypal_payer_email, :paypal_status, :paypal_tx_id, :paypal_tx_type, :price, :order_id
end