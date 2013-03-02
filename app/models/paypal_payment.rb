class PaypalPayment < Payment
  attr_accessible :completed, :completed_at, :paid_amount, :paypal_currency, :paypal_params, :paypal_payer_email, :paypal_status, :paypal_tx_id, :paypal_tx_type, :price
end
