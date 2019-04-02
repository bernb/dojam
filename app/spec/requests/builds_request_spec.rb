require 'rails_helper'

# Kept to demonstrate how a request spec would work
#RSpec.describe "Viewing or editing museum_objects", type: :request do
#  context "by default show requested step" do
#    before(:each) do
#      @museum_object = create(:museum_object)
#    end
#    it "should move back if dependent step/view was choosen by user" do
#      get museum_object_build_path(@museum_object.id, :step_production)
#      expect(response).to redirect_to(
#                                 museum_object_build_path(@museum_object.id, :step_production))
#    end
#  end
#end
