require 'spec_helper'

describe "talk_categories/edit" do
  before(:each) do
    @talk_category = assign(:talk_category, stub_model(TalkCategory,
      :name => "MyString"
    ))
  end

  it "renders the edit talk_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => talk_categories_path(@talk_category), :method => "post" do
      assert_select "input#talk_category_name", :name => "talk_category[name]"
    end
  end
end
