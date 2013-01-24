require "spec_helper"

describe TalkCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/talk_categories").should route_to("talk_categories#index")
    end

    it "routes to #new" do
      get("/talk_categories/new").should route_to("talk_categories#new")
    end

    it "routes to #show" do
      get("/talk_categories/1").should route_to("talk_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/talk_categories/1/edit").should route_to("talk_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/talk_categories").should route_to("talk_categories#create")
    end

    it "routes to #update" do
      put("/talk_categories/1").should route_to("talk_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/talk_categories/1").should route_to("talk_categories#destroy", :id => "1")
    end

  end
end
