require 'spec_helper'

describe "talk_types/show" do
  before(:each) do
    @talk_type = assign(:talk_type, stub_model(TalkType,
      :name => "Name",
      :duration => 1,
      :visible => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/false/)
  end
end
