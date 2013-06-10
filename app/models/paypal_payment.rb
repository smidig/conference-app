# encoding: UTF-8
class PaypalPayment < Payment
  attr_accessible :completed, :completed_at, :paid_amount, :paypal_currency, :paypal_params, :paypal_payer_email, :paypal_status, :paypal_tx_id, :paypal_tx_type, :price

  def payment_url(payment_notifications_url, return_url)
    time = Time.new
    values = {
      :business => PAYMENT_CONFIG[:paypal_email],
      :cmd => '_cart',
      :upload => '1',
      :currency_code => 'NOK',
      :notify_url => payment_notifications_url,
      :return => return_url,
      :invoice => invoice_id,
      :amount_1 => price,
      :item_name_1 => "Smidigkonferansen #{time.year}",
      :item_number_1 => '1',
      :quantity_1 => '1'
    }
    PAYMENT_CONFIG[:paypal_url] + "?"+values.map do
          |k,v| "#{k}=#{CGI::escape(v.to_s)}"
    end.join("&")
  end

  def status
    if completed?
      "Betalt"
    else
      "Venter på betaling hos paypal"
    end
  end
end
