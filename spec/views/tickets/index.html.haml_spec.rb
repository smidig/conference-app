require 'spec_helper'

describe "tickets/index" do

  before(:each) do
    assign(:tickets, [
      stub_model(Ticket,
        :name => "Name",
        :price => 1,
        :active => false,
        :visible => false
      ),
      stub_model(Ticket,
        :name => "Name",
        :price => 1,
        :active => true,
        :visible => true
      )
    ])
  end

  it "renders a list of tickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers

    # Debugging
    #assert_select "td" do |elements|
    #  elements.each do |element|
    #    puts element.to_s
    #  end
    #end

    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => true.to_s, :count => 4
  end
end
