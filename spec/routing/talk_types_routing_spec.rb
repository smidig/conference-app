require "spec_helper"

describe TalkTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/talk_types").should route_to("talk_types#index")
    end

    it "routes to #new" do
      get("/talk_types/new").should route_to("talk_types#new")
    end

    it "routes to #show" do
      get("/talk_types/1").should route_to("talk_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/talk_types/1/edit").should route_to("talk_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/talk_types").should route_to("talk_types#create")
    end

    it "routes to #update" do
      put("/talk_types/1").should route_to("talk_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/talk_types/1").should route_to("talk_types#destroy", :id => "1")
    end

  end
end
