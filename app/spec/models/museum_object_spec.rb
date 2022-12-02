require 'rails_helper'

RSpec.describe MuseumObject, type: :model do
  context 'doing fulltext search' do
    let(:museum1) { create :museum_with_storage_locations }
    let!(:object1) { create :museum_object,
                            storage_location: museum1.storages.first.storage_locations.first,
                            remarks: 'ttt'}
    let(:museum2) { create :museum_with_storage_locations }
    let!(:object2) { create :museum_object,
                            storage_location: museum2.storages.first.storage_locations.first,
                            remarks: 'ttt'}

    context 'by user with extended access' do
      let(:user) { create :ext_user }

      it 'should give results from all museums' do
        result = MuseumObject.search('ttt', user)
        expect(result.count).to eq(2)
      end
    end

    context 'by user without extended access' do
      let(:user) { create :user, museum: museum1 }

      it 'should not give results from all museums' do
        result = MuseumObject.search('ttt', user)
        expect(result.count).to eq(1)
      end
		end
	end
end

RSpec.describe MuseumObject, type: :model do
  context 'using where_path scope' do
    let!(:ms_list) { create_list :ms_with_material, 5}
    let!(:koo_list) { create_list :koo_with_path, 5}
    let!(:koos_list) { create_list :koos_with_path, 5}
    let!(:mo_list) { create_list :mo_without_paths, 10 }
    let(:paths) { Path.all - [Path.undetermined_path] }
    it 'should find undetermined path for every museum object without explicitly set path' do
      expect(MuseumObject.where_path(Path.undetermined_path).count).to eq(10)
    end
    it 'should give no results if path is not associated with any museum object' do
      expect(paths.map{|p| MuseumObject.where_path(p).count}.sum).to eq(0)
    end
    it 'should give one result if path is associated with a single museum object as main path' do

    end
    it 'should give one result if path is associated with a single museum object as secondary path'
    it 'should give two results if path is associated with two museum objects as main path'
    it 'should give two results if path is associated with two museum objects as secondary path'
    it 'should give two results if path is associated with two museum objects as a main and a secondary path respectively'
    it 'should give three results if path is associated with three museum objects'
  end
end

# RSpec.describe MuseumObject, type: :model do
# 	context 'without any set paths' do
#     before(:each) do
#       @museum_object = create(:valid_museum_object)
#     end
# 		it "should allow to set single seconday path as array" do
# 			Path.depth(2).sample(5).each do |path|
# 				@museum_object.secondary_paths = [path]
# 				expect(@museum_object.secondary_paths.count).to eq(1)
# 				expect(@museum_object.secondary_path_ids.first).to eq(path.id)
# 			end
# 		end
#
#     # ToDo: This one did fail in some yet unknown edge case
# 		it "should allow to set single seconday path given as plain object" do
# 			Path.depth(2).sample(50).each do |path|
# 				@museum_object.secondary_paths = path
# 				expect(@museum_object.secondary_paths.count).to eq(1)
# 				expect(@museum_object.secondary_path_ids.first).to eq(path.id)
# 			end
# 		end
#
# 		it "should allow to append single seconday path as array" do
# 			Path.all.sample(5).each do |path|
# 				path_count = @museum_object.secondary_paths.count
# 				@museum_object.secondary_paths << [path]
# 				expect(@museum_object.secondary_paths.count).to eq(path_count+1)
# 			end
# 		end
#
# 		it "should allow to append single seconday path given as plain object" do
# 			Path.all.sample(5).each do |path|
# 				path_count = @museum_object.secondary_paths.count
# 				@museum_object.secondary_paths << path
# 				expect(@museum_object.secondary_paths.count).to eq(path_count+1)
# 			end
# 		end
# 	end
#
# 	context 'with already set paths' do
# 		before(:each) do
# 			@museum_object = create(:valid_museum_object)
# 		end
#
# 		it "should not reject a secondary path that is implied in main path but also implied in a distinct secondary path" do
# 			main_path = Path.depth(4).sample
# 			@museum_object.main_path = main_path
# 			main_path_parent = main_path.to_depth(2)
# 			# We construct a path with same root as the main path but not implied
# 			# Let's say /1/2/3/4 is main path, then we construct /1/5 as a secondary path
# 			secondary_path = main_path_parent
# 				.parent
# 				.direct_children
# 				.reject{|p| p == main_path_parent}
# 				.sample
# 			# Note that we need to also set a parent of main path, otherwise main path
# 			# would get (correctly) removed
# 			@museum_object.secondary_paths = [secondary_path, main_path.to_depth(2)]
# 			expect(@museum_object.secondary_paths.include?(secondary_path)).to be(true)
# 			# The parent path is implied in main path but also in a distinct secondary path
# 			# which we want to keep
# 			new_secondary_path = secondary_path.parent
# 			@museum_object.secondary_paths = new_secondary_path
# 			expect(@museum_object.secondary_paths.include?(secondary_path)).to be(true)
# 		end
#
# 		it "should not lose secondary paths if new paths of lower depth gets newly selected" do
# 			secondary_path = Path.depth(2).sample
# 			@museum_object.secondary_paths = secondary_path
# 			new_path = Path.depth(1).sample
# 			@museum_object.secondary_paths = [new_path, secondary_path.parent]
# 			expect(@museum_object.secondary_paths.include?(secondary_path)).to be(true)
# 		end
#
# 		it "should keep main path if consistent with new choosen secondary paths" do
# 			path = Path.depth(4).sample
# 			@museum_object.main_path = path
# 			expect(@museum_object.main_path).to eq(path)
# 			main_material_path = path.to_depth(1)
# 			@museum_object.secondary_paths = main_material_path
# 			expect(@museum_object.main_path).to eq(path)
# 		end
#
#
# 		it "should remove main path if a parent gets deselected" do
# 			path = Path.depth(4).sample
# 			@museum_object.main_path = path
# 			expect(@museum_object.main_path).to eq(path)
# 			main_material_path = path.to_depth(1)
# 			material_paths = Path.depth(1)
# 			material_paths -= [main_material_path]
# 			expect(material_paths.include?(main_material_path)).to be(false)
# 			@museum_object.secondary_paths = material_paths
#       expect(@museum_object.main_path).to eq(nil)
# 		end
#
# 		it "should ignore new main path if it is a parent of already set main path" do
# 			museum_object = create(:valid_museum_object)
# 			path = Path.depth(4).sample
# 			parent = path.parent
# 			museum_object.main_path = path
# 			expect(museum_object.main_path).to eq(path)
# 			museum_object.main_path = parent
# 			expect(museum_object.main_path).to eq(path)
# 		end
#
# 		it "should ignore if tried to add a parent to existing secondary paths" do
# 			museum_object = create(:valid_museum_object)
# 			Path.depth(2).sample(5).each do |child|
# 				parent = child.parent
# 				museum_object.secondary_paths = child
# 				museum_object.secondary_paths << parent
# 				expect(museum_object.secondary_paths.count).to eq(1)
# 				expect(museum_object.secondary_path_ids.first).to eq(child.id)
# 			end
# 		end
#
# 		it "should ignore if tried to add a parent of main path to secondary paths" do
# 			museum_object = create(:valid_museum_object)
# 			child = Path.all.sample(1).first
# 			parent = child.parent
# 			museum_object.main_path = child
# 			museum_object.secondary_paths = parent
# 			expect(museum_object.secondary_paths.count).to eq(0)
# 		end
#
# 		it "should move old main path information to secondary paths if new main path set" do
# 			museum_object = create(:valid_museum_object)
# 			main_paths = Path.depth(4).sample(2)
# 			expect(main_paths).to be_present
# 			old_main = main_paths.first
# 			new_main = main_paths.last
# 			museum_object.main_path = old_main
# 			expect(museum_object.main_path).to eq(old_main)
# 			museum_object.main_path = new_main
# 			expect(museum_object.main_path).to eq(new_main)
# 			expect(museum_object.secondary_paths).to include(old_main.to_depth(2))
# 		end
#
# 		it "should use parent paths if tried to set secondary paths of depth > 2" do
# 			museum_object = create(:valid_museum_object)
# 			path = Path.depth(4).sample(1).first
# 			museum_object.secondary_paths = path
# 			expect(museum_object.secondary_paths.first).to eq(path.to_depth(2))
# 		end
#
# 		it "should ignore entries of a collection of secondary paths with more specific already existing paths" do
# 			museum_object = create(:valid_museum_object)
# 			paths = Path.depth(2).sample(5)
# 			museum_object.secondary_paths = paths
# 			new_paths = paths.clone
# 			new_paths[1] = new_paths[1].parent
# 			new_paths[3] = new_paths[3].parent
# 			museum_object.secondary_paths = new_paths
# 			expect(museum_object.secondary_paths.map(&:path).sort).to eq(paths.map(&:path).sort)
# 		end
#
# 		it "should ignore if tried to add existing (or implied) main path to secondary paths" do
# 			museum_object = create(:valid_museum_object)
# 			main_path = Path.depth(4).sample
# 			museum_object.main_path = main_path
# 			museum_object.secondary_paths = main_path
# 			expect(museum_object.secondary_paths.count).to eq(0)
# 			museum_object.secondary_paths = main_path.parent
# 			expect(museum_object.secondary_paths.count).to eq(0)
# 		end
#
#     it "should have undetermined path" do
#       expect(@museum_object.main_path&.id).to eq(Path.undetermined_path.id)
#     end
#
#     it "should remove undetermined path if any other path is set" do
#       path = Path.all.sample
#       @museum_object.secondary_paths = path
#       expect(@museum_object.paths.include?(Path.undetermined_path)).to eq(false)
#     end
#
#     it "should not reset undetermined path if reloaded" do
#       path = Path.all.sample
#       @museum_object.secondary_paths = path
#       @museum_object.save
#       @museum_object = MuseumObject.find(@museum_object.id)
#       expect(@museum_object.paths.include?(Path.undetermined_path)).to eq(false)
#     end
# 	end
#
#   it "returns empty array if search does not yield any results" do
#     museum_objects = MuseumObject.search "ffffffffkffkffff"
#     expect(museum_objects).to be_empty
#   end
#
#   it "returns the correct museum objects for existing termlists" do
#     results = MuseumObject.search('red')
#     expect(results.length).to be > 5
#   end
#
#   it "returns an array of museum objects as search results" do
#     for i in 1..100 do
#       term = Termlist.all.sample
#       museum_object = term.museum_objects
#       name = term.name
#       results = MuseumObject.search(name)
#       if results.any?
#         expect(results).to include(museum_object)
#       end
#     end
#   end
#
#end
