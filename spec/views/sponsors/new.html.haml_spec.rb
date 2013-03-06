require 'spec_helper'

describe "sponsors/new" do
  before(:each) do
    assign(:sponsor, stub_model(Sponsor,
      :name => "MyString",
      :url => "MyString",
      :imageUrl => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new sponsor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sponsors_path, :method => "post" do
      assert_select "input#sponsor_name", :name => "sponsor[name]"
      assert_select "input#sponsor_url", :name => "sponsor[url]"
      assert_select "input#sponsor_imageUrl", :name => "sponsor[imageUrl]"
      assert_select "textarea#sponsor_description", :name => "sponsor[description]"
    end
  end
end
