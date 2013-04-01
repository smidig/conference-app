require 'spec_helper'

describe OrdersController do

  describe "GET 'index'" do
    it "returns http success for admin user" do
      user = FactoryGirl.create(:user)
      user.admin = true
      user.save!
      sign_in user

      get 'index'

      response.should be_success
    end

    it "returns redirect to sign_up for non admin user" do
      user = FactoryGirl.create(:user)
      sign_in user

      get 'index'
      response.should be_redirect
    end
  end

end
