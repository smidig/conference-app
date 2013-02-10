require 'spec_helper'

describe PaymentNotificationsController do
  describe "POST create" do
    it "validates raw post with paypal" do
      stub_request(:post, PAYMENT_CONFIG[:paypal_validate_url])
            .with(:body => /.+/)
            .to_return(:status => 200, :body => "VERIFIED", :headers => {})

      post :create, {:param1 => 1, :attr1 => "testValid"}

      assert_requested :post, PAYMENT_CONFIG[:paypal_validate_url], :body => /attr1=testValid/
    end
    it "should raise error if paypal-validation fails" do
      stub_request(:post, PAYMENT_CONFIG[:paypal_validate_url])
            .to_return(:status => 200, :body => "INVALID", :headers => {})

      expect {
        post :create, {:param1 => 1, :attr1 => "testValid"}
      }.to raise_error
    end
  end
end