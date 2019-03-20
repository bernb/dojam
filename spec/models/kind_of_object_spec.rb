require 'rails_helper'

RSpec.describe KindOfObject, type: :model  do
  it 'should show unique entries for specified kind of object' do
    kind_of_object = KindOfObject.find_by name: 'undetermined'
    material_specified = MaterialSpecified.find_by name: 'undetermined'
    specified_list = kind_of_object.kind_of_object_specifieds(
      material_specified: material_specified)
    specified_names = specified_list.map(&:name)
    expect(specified_names.select{|t| t == "undetermined"}.count).to eq(1)
  end
end
