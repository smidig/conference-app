require 'spec_helper'

describe "talk_types/edit" do
  before(:each) do
    @talk_type = assign(:talk_type, stub_model(TalkType,
      :name => "MyString",
      :duration => 1,
      :visible => false
    ))
  end

  it "renders the edit talk_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => talk_types_path(@talk_type), :method => "post" do
      assert_select "input#talk_type_name", :name => "talk_type[name]"
      assert_select "input#talk_type_duration", :name => "talk_type[duration]"
      assert_select "input#talk_type_visible", :name => "talk_type[visible]"
    end
  end
end
