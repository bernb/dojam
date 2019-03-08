require 'rails_helper'

RSpec.describe "Viewing or editing museum_objects", type: :request do
  context "when no main path is set" do
    before(:each) do
      @museum_object = create(:pathless_museum_object)
    end
    it "should move back if dependent step/view was choosen by user" do
      get museum_object_build_path(@museum_object.id, :step_production)
      expect(response).to redirect_to(
                                 museum_object_build_path(@museum_object.id, :step_confirm))
    end
  end
end
