require 'spec_helper'

describe "talk_categories/show" do
  before(:each) do
    @talk_category = assign(:talk_category, stub_model(TalkCategory,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
