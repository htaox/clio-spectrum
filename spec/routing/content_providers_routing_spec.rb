require "spec_helper"

describe ContentProvidersController do
  describe "routing" do

    it "routes to #index" do
      get("/content_providers").should route_to("content_providers#index")
    end

    it "routes to #new" do
      get("/content_providers/new").should route_to("content_providers#new")
    end

    it "routes to #show" do
      get("/content_providers/1").should route_to("content_providers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/content_providers/1/edit").should route_to("content_providers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/content_providers").should route_to("content_providers#create")
    end

    it "routes to #update" do
      put("/content_providers/1").should route_to("content_providers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/content_providers/1").should route_to("content_providers#destroy", :id => "1")
    end

  end
end
