require 'spec_helper'

describe "Tickets" do
  describe "GET /tickets" do
    it "should require login" do
      get tickets_path
      response.status.should be(302)
    end
  end
end
