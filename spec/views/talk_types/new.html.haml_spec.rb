require 'spec_helper'

describe "talk_types/new" do
  before(:each) do
    assign(:talk_type, stub_model(TalkType,
      :name => "MyString",
      :duration => 1,
      :visible => false
    ).as_new_record)
  end

  it "renders new talk_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => talk_types_path, :method => "post" do
      assert_select "input#talk_type_name", :name => "talk_type[name]"
      assert_select "input#talk_type_duration", :name => "talk_type[duration]"
      assert_select "input#talk_type_visible", :name => "talk_type[visible]"
    end
  end
end
