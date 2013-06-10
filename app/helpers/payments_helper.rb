module PaymentsHelper
  def manual_address(payment)
    content_tag(:div) do
      if payment.manual_company_email
          payment.manual_company_email
      else
        concat payment.manual_company_name
        concat tag(:br)
        concat payment.manual_street_address
        concat tag(:br)
        concat payment.manual_post_code
      end
    end
  end
  def participants(payment)
    content_tag(:div) do
      payment.order.users.each do |user|
        concat user.name
        concat tag(:br)
      end
    end
  end
end
