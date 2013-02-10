require "net/http"
class PaymentNotificationsController < ApplicationController
  def create
    isValid = validate(request.raw_post)

    puts "isValid: #{isValid}"
    puts "using create"
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
