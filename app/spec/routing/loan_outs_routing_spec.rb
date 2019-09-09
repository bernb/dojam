require "rails_helper"

RSpec.describe LoanOutsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/loan_outs").to route_to("loan_outs#index")
    end

    it "routes to #new" do
      expect(:get => "/loan_outs/new").to route_to("loan_outs#new")
    end

    it "routes to #show" do
      expect(:get => "/loan_outs/1").to route_to("loan_outs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/loan_outs/1/edit").to route_to("loan_outs#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/loan_outs").to route_to("loan_outs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/loan_outs/1").to route_to("loan_outs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/loan_outs/1").to route_to("loan_outs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/loan_outs/1").to route_to("loan_outs#destroy", :id => "1")
    end
  end
end
