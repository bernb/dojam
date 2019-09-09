require 'rails_helper'

RSpec.describe "loan_outs/show", type: :view do
  before(:each) do
    @loan_out = assign(:loan_out, LoanOut.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
