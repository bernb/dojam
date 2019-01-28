require 'rails_helper'

RSpec.describe "Database for Testing" do
	it "should have paths of depth one to four" do
		expect(Path.depth(1).count).to be > 1
		expect(Path.depth(2).count).to be > 10
		expect(Path.depth(3).count).to be > 10
		expect(Path.depth(4).count).to be > 10
	end

	it "should contain multiple termlists" do
		expect(Termlist.all.count).to be > 10
	end
end
