require 'rails_helper'

RSpec.describe Material, type: :model do
  it "should be able to instantiate a single material" do
    material = create(:material)
    expect(material).not_to be_nil
  end

  it "should have depth == 1" do
    material = create(:material)
    expect(material.depth).to eq(1)
  end

  it "should have a path to itself" do
    material = create(:material)
    expect(material.path.path).to eq("/#{material.id}")
  end

  it "should destroy path to self if destroyed" do
    material = create(:material)
    material.destroy
    expect(material.path).to be_nil
  end

  it "should destroy join table entry to own path if destroyed" do
    material = create(:material)
    material.destroy
    expect(material.termlist_paths).to be_empty
  end
end