require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TalkTypesController do

  # This should return the minimal set of attributes required to create a valid
  # TalkType. As you add validations to TalkType, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  login_admin

  describe "GET index" do
    it "assigns all talk_types as @talk_types" do
      talk_type = TalkType.all
      get :index, {}
      assigns(:talk_types).should eq(talk_type)
    end
  end

  describe "GET show" do
    it "assigns the requested talk_type as @talk_type" do
      talk_type = TalkType.create! valid_attributes
      get :show, {:id => talk_type.to_param}
      assigns(:talk_type).should eq(talk_type)
    end
  end

  describe "GET new" do
    it "assigns a new talk_type as @talk_type" do
      get :new, {}
      assigns(:talk_type).should be_a_new(TalkType)
    end
  end

  describe "GET edit" do
    it "assigns the requested talk_type as @talk_type" do
      talk_type = TalkType.create! valid_attributes
      get :edit, {:id => talk_type.to_param}
      assigns(:talk_type).should eq(talk_type)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TalkType" do
        expect {
          post :create, {:talk_type => valid_attributes}
        }.to change(TalkType, :count).by(1)
      end

      it "assigns a newly created talk_type as @talk_type" do
        post :create, {:talk_type => valid_attributes}
        assigns(:talk_type).should be_a(TalkType)
        assigns(:talk_type).should be_persisted
      end

      it "redirects to the created talk_type" do
        post :create, {:talk_type => valid_attributes}
        response.should redirect_to(TalkType.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved talk_type as @talk_type" do
        # Trigger the behavior that occurs when invalid params are submitted
        TalkType.any_instance.stub(:save).and_return(false)
        post :create, {:talk_type => { "name" => "invalid value" }}
        assigns(:talk_type).should be_a_new(TalkType)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TalkType.any_instance.stub(:save).and_return(false)
        post :create, {:talk_type => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested talk_type" do
        talk_type = TalkType.create! valid_attributes
        # Assuming there are no other talk_types in the database, this
        # specifies that the TalkType created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TalkType.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => talk_type.to_param, :talk_type => { "name" => "MyString" }}
      end

      it "assigns the requested talk_type as @talk_type" do
        talk_type = TalkType.create! valid_attributes
        put :update, {:id => talk_type.to_param, :talk_type => valid_attributes}
        assigns(:talk_type).should eq(talk_type)
      end

      it "redirects to the talk_type" do
        talk_type = TalkType.create! valid_attributes
        put :update, {:id => talk_type.to_param, :talk_type => valid_attributes}
        response.should redirect_to(talk_type)
      end
    end

    describe "with invalid params" do
      it "assigns the talk_type as @talk_type" do
        talk_type = TalkType.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TalkType.any_instance.stub(:save).and_return(false)
        put :update, {:id => talk_type.to_param, :talk_type => { "name" => "invalid value" }}
        assigns(:talk_type).should eq(talk_type)
      end

      it "re-renders the 'edit' template" do
        talk_type = TalkType.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TalkType.any_instance.stub(:save).and_return(false)
        put :update, {:id => talk_type.to_param, :talk_type => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested talk_type" do
      talk_type = TalkType.create! valid_attributes
      expect {
        delete :destroy, {:id => talk_type.to_param}
      }.to change(TalkType, :count).by(-1)
    end

    it "redirects to the talk_types list" do
      talk_type = TalkType.create! valid_attributes
      delete :destroy, {:id => talk_type.to_param}
      response.should redirect_to(talk_types_url)
    end
  end

end
