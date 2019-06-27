require 'rails_helper'

RSpec.describe "acquisition_delivered_bies/index", type: :view do
  before(:each) do
    assign(:acquisition_delivered_bies, [
      AcquisitionDeliveredBy.create!(
        :name => "Name"
      ),
      AcquisitionDeliveredBy.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of acquisition_delivered_bies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
