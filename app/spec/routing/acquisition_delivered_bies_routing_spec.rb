require "rails_helper"

RSpec.describe AcquisitionDeliveredBiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/acquisition_delivered_bies").to route_to("acquisition_delivered_bies#index")
    end

    it "routes to #new" do
      expect(:get => "/acquisition_delivered_bies/new").to route_to("acquisition_delivered_bies#new")
    end

    it "routes to #show" do
      expect(:get => "/acquisition_delivered_bies/1").to route_to("acquisition_delivered_bies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/acquisition_delivered_bies/1/edit").to route_to("acquisition_delivered_bies#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/acquisition_delivered_bies").to route_to("acquisition_delivered_bies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/acquisition_delivered_bies/1").to route_to("acquisition_delivered_bies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/acquisition_delivered_bies/1").to route_to("acquisition_delivered_bies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/acquisition_delivered_bies/1").to route_to("acquisition_delivered_bies#destroy", :id => "1")
    end
  end
end
