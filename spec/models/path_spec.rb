require 'rails_helper'

RSpec.describe Path, type: :model do
	it "should return that nil is not included or parent of instance" do
		path = Path.all.sample
		expect(path.included_or_parent_of?(nil)).to be(false)
	end

	it "should return correct value if asked if instance is included or parent of array or single instance" do
		path = Path.depth(3).sample
		children = path.direct_children
		child = children.first
		expect(path.included_or_parent_of?(child)).to be(true)
		expect(path.included_or_parent_of?(children)).to be(true)
	end

	it "should return true if child_of?(path) is called on path's parent" do
		path = Path.depth(3).sample
		parent = path.parent
		expect(path.child_of?(parent)).to be(true)
	end

	it "should return true if child_of?(path) is called on an indirect parent" do
		path = Path.depth(3).sample
		parent = path.parent.parent
		expect(path.child_of?(parent)).to be(true)
	end

	it "should return true if included_or_child_of?(paths) is called on a path that's a parent of a path's element" do
		parents = Path.depth(3).sample(5)
		child = parents.sample.direct_children.sample
		expect(child.included_or_child_of?(parents)).to be(true)
	end

	it "should return true if included_or_child_of?(paths) is called on a path that's an indirect parent of a path's element" do
		parents = Path.depth(2).sample(5)
		child = parents.sample.direct_children.sample.direct_children.sample
		expect(child.included_or_child_of?(parents)).to be(true)
	end

	it "should return true if included_or_child_of?(paths) is called on a path that is included in paths" do
		paths = Path.depth(3).sample(5)
		path = paths.sample
		expect(path.included_or_child_of?(paths)).to be(true)
	end
end
