# Used to mock away the paypal redirect as it seemed impossible to verify
Given /^user will complete at paypal$/ do
  PaymentsController.any_instance.stubs(:get_paypal_url).returns(payments_paypal_completed_path)
end

Then(/^It should exist one paypal payment$/) do
  PaypalPayment.all.size.should eq(1)
end
