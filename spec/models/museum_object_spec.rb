require 'rails_helper'

RSpec.describe MuseumObject, type: :model do
	it "should allow to set single seconday path as array" do
		museum_object = create(:museum_object)
		Path.all.sample(25).each do |path|
			museum_object.secondary_paths = [path]
			expect(museum_object.secondary_paths.count).to eq(1)
			expect(museum_object.secondary_path_ids.first).to eq(path.id)
		end
	end

	it "should ignore if tried to add a parent to existing secondary paths" do
		museum_object = create(:museum_object)
		Path.depth(2).sample(25).each do |child|
			parent = child.parent
			museum_object.secondary_paths = child
			museum_object.secondary_paths << parent
			expect(museum_object.secondary_paths.count).to eq(1)
			expect(museum_object.secondary_path_ids.first).to eq(child.id)
		end
	end

	it "should ignore if tried to add a parent of main path to secondary paths" do
		museum_object = create(:museum_object)
		Path.depth(2).sample(25).each do |child|
			parent = child.parent
			museum_object.main_path = child
			museum_object.secondary_paths << parent
			expect(museum_object.secondary_paths.count).to eq(0)
		end
	end

	it "should move old main path information to secondary paths if new main path set" do
		main_paths = Path.depth(4).sample(2)
		expect(main_paths).to be_present
		old_main = main_paths.first
		new_main = main_paths.last
		museum_object.main_path = old_main
		museum_object.main_path = new_main
		expect(museum_object.main_path).to eq(new_main)
		expect(museum_object.secondary_paths).to include(old_main.parent)
	end





	it "should use parent paths if tried to set secondary paths of depth > 2"
	it "should replace entries of a collection of secondary paths with more specific already existing paths"
	it "should ignore if tried to add existing main path to secondary paths"
	it "should only keep most specific secondary paths if new collection is added"
end
