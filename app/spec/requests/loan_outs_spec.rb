require 'rails_helper'

RSpec.describe "LoanOuts", type: :request do
  describe "GET /loan_outs" do
    it "works! (now write some real specs)" do
      get loan_outs_path
      expect(response).to have_http_status(200)
    end
  end
end
