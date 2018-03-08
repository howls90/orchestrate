class Api::V1::RrhsController < ApplicationController
  before_action :set_rrh, only: [:show, :update, :destroy]
  
  def index
    render json: Rrh.all
  end

  def show
    render json: @rrh
  end

  # POST /scripts
  # POST /scripts.json
  def create
    @scenario = Scenario.find(params[:scenario_id])
    @rrh = @scenario.rrhs.new(rrh_params)
    if @rrh.save
      render json: @rrh 
    else
      render json: {status: 'ERROR', data: @rrh.errors}
    end
  end

  # PATCH/PUT /rrhs/1
  # PATCH/PUT /rrhs/1.json
  def update
    @scenario = Scenario.find(params[:scenario_id])
    @rrh = @scenario.rrhs.find(params[:id])
    if @rrh.update(rrh_params)
      render json: @rrh
    else
      render json: {status: "ERROR", data: @rrh.error}
    end
  end

  def destroy
    @rrh.destroy
    render json: {status: 'SUCCESS', message:'RRH deleted'}, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rrh
    @rrh = Rrh.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rrh_params
    params.permit(:ip, :model, :version, :latitude, :longitude)
  end
end
