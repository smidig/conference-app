require 'spec_helper'

describe AdministrationController do

  describe "GET 'registrations'" do
    it "returns http success" do
      get 'registrations'
      response.should be_success
    end
  end

  describe "GET 'send_mail'" do
    it "returns http success" do
      get 'send_mail'
      response.should be_success
    end
  end

  describe "GET 'statistics'" do
    it "returns http success" do
      get 'statistics'
      response.should be_success
    end
  end

end
