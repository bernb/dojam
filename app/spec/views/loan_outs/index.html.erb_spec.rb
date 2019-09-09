require 'rails_helper'

RSpec.describe "loan_outs/index", type: :view do
  before(:each) do
    assign(:loan_outs, [
      LoanOut.create!(),
      LoanOut.create!()
    ])
  end

  it "renders a list of loan_outs" do
    render
  end
end
