require 'rails_helper'

RSpec.describe "loan_outs/new", type: :view do
  before(:each) do
    assign(:loan_out, LoanOut.new())
  end

  it "renders new loan_out form" do
    render

    assert_select "form[action=?][method=?]", loan_outs_path, "post" do
    end
  end
end
