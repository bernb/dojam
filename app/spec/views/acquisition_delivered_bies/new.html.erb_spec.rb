require 'rails_helper'

RSpec.describe "acquisition_delivered_bies/new", type: :view do
  before(:each) do
    assign(:acquisition_delivered_by, AcquisitionDeliveredBy.new(
      :name => "MyString"
    ))
  end

  it "renders new acquisition_delivered_by form" do
    render

    assert_select "form[action=?][method=?]", acquisition_delivered_bies_path, "post" do

      assert_select "input[name=?]", "acquisition_delivered_by[name]"
    end
  end
end
