require 'rails_helper'

RSpec.describe "acquisition_delivered_bies/edit", type: :view do
  before(:each) do
    @acquisition_delivered_by = assign(:acquisition_delivered_by, AcquisitionDeliveredBy.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit acquisition_delivered_by form" do
    render

    assert_select "form[action=?][method=?]", acquisition_delivered_by_path(@acquisition_delivered_by), "post" do

      assert_select "input[name=?]", "acquisition_delivered_by[name]"
    end
  end
end
