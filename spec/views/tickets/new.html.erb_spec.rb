require 'spec_helper'

describe "tickets/new" do
  before(:each) do
    assign(:ticket, stub_model(Ticket,
      :name => "MyString",
      :price => 1,
      :active => false,
      :visible => false
    ).as_new_record)
  end

  it "renders new ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path, :method => "post" do
      assert_select "input#ticket_name", :name => "ticket[name]"
      assert_select "input#ticket_price", :name => "ticket[price]"
      assert_select "input#ticket_active", :name => "ticket[active]"
      assert_select "input#ticket_visible", :name => "ticket[visible]"
    end
  end
end
