class Api::V1::RrhsController < ApplicationController
  before_action :set_rrh, only: [:show, :update, :destroy]
        
  swagger_controller :Rrhs, "Radio Remote Heads Management"

  swagger_api :index do
    summary "Fetches all RRHs"
    notes "This lists all the RRHs"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end
  
  def index
    render json: Rrh.all
  end

 swagger_api :show do
    summary "Show RRH content"
    param :path, :id, :integer, :required, "RRH ID"
    response :ok, "Success", :Rrh
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def show
    render json: @rrh
  end

  swagger_api :create do
    summary "Create new Radio Remote Head"
    notes "Create radio Remote Head"
    param :form, :ip, :string, :required, "IP"
    param :form, :model, :string, :required, "Model"
    param :form, :version, :string, :required, "Version"
    param :form, :latitude, :float, :required, "Latitude"
    param :form, :longitude, :float, :required, "Longitude"
    param :path, :scenario_id, :long, :required, "Scenario ID"
    response :ok
    response :unauthorized
    response :not_acceptable
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

  swagger_api :update do
    summary "Update existing Radio Remote Head"
    notes "Update Radio Remote Head"
    param :path, :id, :integer, :required, "RRH ID"
    param :form, :ip, :string, :optional, "IP"
    param :form, :model, :string, :optional, "Model"
    param :form, :version, :string, :optional, "Version"
    param :form, :latitude, :float, :optional, "Latitude"
    param :form, :longitude, :float, :optional, "Longitude"
    param :path, :scenario_id, :integer, :required, "Scenario ID"
    response :ok
    response :unauthorized
    response :not_acceptable
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

  swagger_api :destroy do
    summary "Deletes an existing Radio Remote Head"
    param :path, :id, :integer, :required, "RRH ID"
    response :ok
    response :unauthorized
    response :not_found
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
