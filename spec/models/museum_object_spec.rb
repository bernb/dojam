require 'rails_helper'

RSpec.describe MuseumObject, type: :model do
	it "should allow to set single seconday path as array" do
		museum_object = create(:valid_museum_object)
		Path.sample(25).each do |path|
			museum_object.secondary_path = path
		end
	end
end
