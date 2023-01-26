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

  it "should be allowed to be destroyed if no museum object is associated" do
    museum_object = create(:museum_object_with_main_path)
    material = museum_object.main_material
    museum_object.destroy
    material.destroy
    expect(material.destroyed?).to be true
  end
  it "should not be allowed to be destroyed if a museum object is associated" do
    museum_object = create(:museum_object_with_main_path)
    material = museum_object.main_material
    material.destroy
    expect(material.destroyed?).to be false
  end

  it "should clean up the join table termlist_paths if destroyed" do
    museum_object = create(:museum_object_with_main_path)
    join_table_entry_count = TermlistPath.count
    material = museum_object.main_material
    museum_object.destroy
    material.destroy
    expect(TermlistPath.count).to eq(join_table_entry_count-1)
  end
end