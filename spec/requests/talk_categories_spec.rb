require 'spec_helper'

describe "TalkCategories" do
  describe "GET /talk_categories" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get talk_categories_path
      response.status.should be(302)
    end
  end
end
