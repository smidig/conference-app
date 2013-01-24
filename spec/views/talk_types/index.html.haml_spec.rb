require 'spec_helper'

describe "talk_types/index" do
  before(:each) do
    assign(:talk_types, [
      stub_model(TalkType,
        :name => "Name",
        :duration => 1,
        :visible => false
      ),
      stub_model(TalkType,
        :name => "Name",
        :duration => 1,
        :visible => false
      )
    ])
  end

  it "renders a list of talk_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
