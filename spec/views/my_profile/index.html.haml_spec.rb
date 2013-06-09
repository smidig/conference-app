require 'spec_helper'

describe "my_profile/index" do
  before(:each) do
    @user = assign(:user, FactoryGirl.build(:user))
    render
  end

  it "should greet the user" do
    response.should contain("Hei #{@user.name}")
  end

  it "should contain a link to edit profile" do
    response.should have_selector 'a', :href => edit_user_registration_path
  end
end
