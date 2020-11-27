class LoanOutsController < ApplicationController
  before_action :set_loan_out, only: [:show, :edit, :update, :destroy]

  def index
    @loan_outs = LoanOut.all
  end

  def show
  end

  def new
    @loan_out = LoanOut.new
  end

  def edit
  end

  def create
    @loan_out = LoanOut.new(loan_out_params)
    if @loan_out.save
      redirect_to @loan_out
      flash[:success] = 'loan was successfully created'
    else
      render :new
    end
  end

  def update
    if @loan_out.update(loan_out_params)
      redirect_to @loan_out
      flash[:success] =  t('loan_successfully_updated')
    else
      render :edit
      flash[:warning] = t('could_not_update_loan_please_check_inputs')
    end
  end

  def destroy
    @loan_out.destroy
    redirect_to loan_outs_url
    flash[:success] = 'loan out was successfully destroyed'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan_out
      @loan_out = LoanOut.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_out_params
      params.require(:loan_out).permit( 
        :to_institution,
        :borrower_name,
        :borrower_job_title,
        :date_out,
        :request_document_number,
        :request_document_date,
        :request_document_signed_by,
        :lender_name,
        :lender_job_title,
        :loan_document_number,
        :object_condition,
        :return_date,
        :planned_return,
        :museum_object_id)
    end
end
