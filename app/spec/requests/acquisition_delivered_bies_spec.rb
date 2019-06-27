require 'rails_helper'

RSpec.describe "AcquisitionDeliveredBies", type: :request do
  describe "GET /acquisition_delivered_bies" do
    it "works! (now write some real specs)" do
      get acquisition_delivered_bies_path
      expect(response).to have_http_status(200)
    end
  end
end
