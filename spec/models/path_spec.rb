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
end
