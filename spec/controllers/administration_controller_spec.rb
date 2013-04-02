require 'spec_helper'

describe AdministrationController do
  login_admin

  describe "GET 'registrations'" do
    it "returns http success" do
      get 'registrations'
       expect(response.code).to eq("200")
    end
  end

  describe "GET 'send_mail'" do
    it "returns http success" do
      get 'send_mail'
       expect(response.code).to eq("200")
    end
  end

  describe "GET 'statistics'" do
    it "returns http success" do
      get 'statistics'
       expect(response.code).to eq("200")
    end
  end

end
