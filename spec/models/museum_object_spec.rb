require 'rails_helper'

RSpec.describe MuseumObject, type: :model do
	context 'without any set paths' do
		it "should allow to set single seconday path as array" do
			museum_object = create(:museum_object)
			Path.depth(2).sample(5).each do |path|
				museum_object.secondary_paths = [path]
				expect(museum_object.secondary_paths.count).to eq(1)
				expect(museum_object.secondary_path_ids.first).to eq(path.id)
			end
		end

		it "should allow to set single seconday path given as plain object" do
			museum_object = create(:museum_object)
			Path.depth(2).sample(5).each do |path|
				museum_object.secondary_paths = path
				expect(museum_object.secondary_paths.count).to eq(1)
				expect(museum_object.secondary_path_ids.first).to eq(path.id)
			end
		end

		it "should allow to append single seconday path as array" do
			museum_object = create(:museum_object)
			Path.all.sample(5).each do |path|
				path_count = museum_object.secondary_paths.count
				museum_object.secondary_paths << [path]
				expect(museum_object.secondary_paths.count).to eq(path_count+1)
			end
		end

		it "should allow to append single seconday path given as plain object" do
			museum_object = create(:museum_object)
			Path.all.sample(5).each do |path|
				path_count = museum_object.secondary_paths.count
				museum_object.secondary_paths << path
				expect(museum_object.secondary_paths.count).to eq(path_count+1)
			end
		end
	end

	context 'with already set paths' do
		before(:each) do
			@museum_object = create(:museum_object)
		end

		it "should not lose secondary paths if new paths of lower depth gets newly selected" do
			secondary_path = Path.depth(2).sample
			@museum_object.secondary_paths = secondary_path
			new_path = Path.depth(1).sample
			@museum_object.secondary_paths = new_path
			expect(@museum_object.secondary_paths.include?(secondary_path)).to be(true)
		end

		it "should keep main path if consistent with new choosen secondary paths" do
			path = Path.depth(4).sample
			@museum_object.main_path = path
			expect(@museum_object.main_path).to eq(path)
			main_material_path = path.to_depth(1)
			@museum_object.secondary_paths = main_material_path
			expect(@museum_object.main_path).to eq(path)
		end


		it "should remove main path if a parent gets deselected" do
			path = Path.depth(4).sample
			@museum_object.main_path = path
			expect(@museum_object.main_path).to eq(path)
			main_material_path = path.to_depth(1)
			material_paths = Path.depth(1)
			material_paths -= [main_material_path]
			expect(material_paths.include?(main_material_path)).to be(false)
			@museum_object.secondary_paths = material_paths
			expect(@museum_object.main_path).to eq(nil)
		end

		it "should ignore new main path if it is a parent of already set main path" do
			museum_object = create(:museum_object)
			path = Path.depth(4).sample
			parent = path.parent
			museum_object.main_path = path
			expect(museum_object.main_path).to eq(path)
			museum_object.main_path = parent
			expect(museum_object.main_path).to eq(path)
		end

		it "should ignore if tried to add a parent to existing secondary paths" do
			museum_object = create(:museum_object)
			Path.depth(2).sample(5).each do |child|
				parent = child.parent
				museum_object.secondary_paths = child
				museum_object.secondary_paths << parent
				expect(museum_object.secondary_paths.count).to eq(1)
				expect(museum_object.secondary_path_ids.first).to eq(child.id)
			end
		end

		it "should ignore if tried to add a parent of main path to secondary paths" do
			museum_object = create(:museum_object)
			child = Path.all.sample(1).first
			parent = child.parent
			museum_object.main_path = child
			museum_object.secondary_paths << parent
			expect(museum_object.secondary_paths.count).to eq(0)
		end

		it "should move old main path information to secondary paths if new main path set" do
			museum_object = create(:museum_object)
			main_paths = Path.depth(4).sample(2)
			expect(main_paths).to be_present
			old_main = main_paths.first
			new_main = main_paths.last
			museum_object.main_path = old_main
			expect(museum_object.main_path).to eq(old_main)
			museum_object.main_path = new_main
			expect(museum_object.main_path).to eq(new_main)
			expect(museum_object.secondary_paths).to include(old_main.to_depth(2))
		end

		it "should use parent paths if tried to set secondary paths of depth > 2" do
			museum_object = create(:museum_object)
			path = Path.depth(4).sample(1).first
			museum_object.secondary_paths = path
			expect(museum_object.secondary_paths.first).to eq(path.to_depth(2))
		end

		it "should ignore entries of a collection of secondary paths with more specific already existing paths" do
			museum_object = create(:museum_object)
			paths = Path.depth(2).sample(5)
			museum_object.secondary_paths = paths
			new_paths = paths.clone
			new_paths[1] = new_paths[1].parent
			new_paths[3] = new_paths[3].parent
			museum_object.secondary_paths = new_paths
			expect(museum_object.secondary_paths.map(&:path).sort).to eq(paths.map(&:path).sort)
		end

		it "should ignore if tried to add existing (or implied) main path to secondary paths" do
			museum_object = create(:museum_object)
			main_path = Path.depth(4).sample
			museum_object.main_path = main_path
			museum_object.secondary_paths << main_path
			expect(museum_object.secondary_paths.count).to eq(0)
			museum_object.secondary_paths << main_path.parent
			expect(museum_object.secondary_paths.count).to eq(0)
		end

	end

end
