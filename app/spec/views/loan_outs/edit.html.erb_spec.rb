require 'rails_helper'

RSpec.describe "loan_outs/edit", type: :view do
  before(:each) do
    @loan_out = assign(:loan_out, LoanOut.create!())
  end

  it "renders the edit loan_out form" do
    render

    assert_select "form[action=?][method=?]", loan_out_path(@loan_out), "post" do
    end
  end
end
