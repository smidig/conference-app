require "net/http"
class PaymentNotificationsController < ApplicationController
  def create
    isValid = validate(request.raw_post)
    payment = Payment.find_by_invoice_id(params[:invoice])
    unless payment.nil?
      payment.paid_amount = params[:mc_gross].to_i
      payment.paypal_currency = params[:mc_currency]
      payment.paypal_tx_id = params[:txn_id]
      payment.paypal_tx_type = params[:txn_type]
      payment.paypal_status = params[:payment_status]
      payment.paypal_payer_email = params[:payer_email]
      payment.paypal_params = params

      # TODO: verify that it is actually is correct amount!
      payment.completed_at = Time.now
      payment.completed = true


      puts "isValid: #{isValid}"
      puts "using create"
      payment.save!
    end

    render :nothing => true
  end

  private

  def validate(raw_post)
    uri = URI.parse(PAYMENT_CONFIG[:paypal_url] +'?cmd=_notify-validate')

    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, raw_post,
                         'Content-Length' => "#{raw_post.size}",
                         'User-Agent' => "My custom user agent"
                       ).body

    raise StandardError.new("Faulty paypal result: #{response}") unless ["VERIFIED", "INVALID"].include?(response)
    raise StandardError.new("Invalid IPN: #{response}") unless response == "VERIFIED"

    true
  end
end
