require 'spec_helper'

describe "sponsors/index" do
  before(:each) do
    assign(:sponsors, [
      stub_model(Sponsor,
        :name => "Name",
        :url => "Url",
        :imageUrl => "Image Url",
        :description => "MyText"
      ),
      stub_model(Sponsor,
        :name => "Name",
        :url => "Url",
        :imageUrl => "Image Url",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of sponsors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
