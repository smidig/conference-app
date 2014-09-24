require 'spec_helper'

describe UsersController, :type => :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @user.admin = true
    @user.save!
    sign_in @user
  end
  describe "GET #index" do
    it "populates an array of users" do
      get :index
      assigns(:users).should include(@user)
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe "GET #index should require admin" do
    it "verify that user is admin" do
      sign_out @user
      u = FactoryGirl.create(:user)
      sign_in u
      get :index
      response.should_not render_template :index
    end
  end
end
