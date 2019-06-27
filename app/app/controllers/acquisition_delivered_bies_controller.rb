class AcquisitionDeliveredBiesController < ApplicationController
  before_action :set_acquisition_delivered_by, only: [:show, :edit, :update, :destroy]

  # GET /acquisition_delivered_bies
  # GET /acquisition_delivered_bies.json
  def index
    @acquisition_delivered_bies = AcquisitionDeliveredBy.all
  end

  # GET /acquisition_delivered_bies/1
  # GET /acquisition_delivered_bies/1.json
  def show
  end

  # GET /acquisition_delivered_bies/new
  def new
    @acquisition_delivered_by = AcquisitionDeliveredBy.new
  end

  # GET /acquisition_delivered_bies/1/edit
  def edit
  end

  # POST /acquisition_delivered_bies
  # POST /acquisition_delivered_bies.json
  def create
    @acquisition_delivered_by = AcquisitionDeliveredBy.new(acquisition_delivered_by_params)

    respond_to do |format|
      if @acquisition_delivered_by.save
        format.html { redirect_to @acquisition_delivered_by, notice: 'Acquisition delivered by was successfully created.' }
        format.json { render :show, status: :created, location: @acquisition_delivered_by }
      else
        format.html { render :new }
        format.json { render json: @acquisition_delivered_by.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acquisition_delivered_bies/1
  # PATCH/PUT /acquisition_delivered_bies/1.json
  def update
    respond_to do |format|
      if @acquisition_delivered_by.update(acquisition_delivered_by_params)
        format.html { redirect_to @acquisition_delivered_by, notice: 'Acquisition delivered by was successfully updated.' }
        format.json { render :show, status: :ok, location: @acquisition_delivered_by }
      else
        format.html { render :edit }
        format.json { render json: @acquisition_delivered_by.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acquisition_delivered_bies/1
  # DELETE /acquisition_delivered_bies/1.json
  def destroy
    @acquisition_delivered_by.destroy
    respond_to do |format|
      format.html { redirect_to acquisition_delivered_bies_url, notice: 'Acquisition delivered by was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acquisition_delivered_by
      @acquisition_delivered_by = AcquisitionDeliveredBy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acquisition_delivered_by_params
      params.require(:acquisition_delivered_by).permit(:name)
    end
end
