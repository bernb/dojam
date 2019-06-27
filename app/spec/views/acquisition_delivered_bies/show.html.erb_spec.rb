require 'rails_helper'

RSpec.describe "acquisition_delivered_bies/show", type: :view do
  before(:each) do
    @acquisition_delivered_by = assign(:acquisition_delivered_by, AcquisitionDeliveredBy.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
