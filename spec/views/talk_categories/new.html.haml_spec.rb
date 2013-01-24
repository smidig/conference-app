require 'spec_helper'

describe "talk_categories/new" do
  before(:each) do
    assign(:talk_category, stub_model(TalkCategory,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new talk_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => talk_categories_path, :method => "post" do
      assert_select "input#talk_category_name", :name => "talk_category[name]"
    end
  end
end
