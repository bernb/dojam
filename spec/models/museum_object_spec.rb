require 'rails_helper'

RSpec.describe MuseumObject, type: :model do
	it "should allow to set single seconday path as array" do
		museum_object = create(:museum_object)
		Path.all.sample(25).each do |path|
			museum_object.secondary_path = path
			expect(museum_object.secondary_paths.count).to eq(1)
			expect(museum_object.secondary_path_ids.first).to eq(path.id)
		end
	end
end
