# encoding: UTF-8
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
    if self.completed?
      "Betalt"
    else
      "Venter på betaling hos paypal"
    end
  end
end
