class Api::V1::VnfsController < ApplicationController
  before_action :set_vnf, only: [:show, :edit, :update, :destroy]

  swagger_controller :Vnfs, "VNF Management"

  swagger_api :index do
    summary "Fetches all VNFs"
    notes "This lists all VNFs"
    response :ok
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :request_range_not_satisfiable
  end

  # GET /vnfs
  # GET /vnfs.json
  def index
    render json: Vnf.all
  end

  swagger_api :show do
    summary "Show VNF content"
    param :path, :id, :integer, :requiere, "VNF ID"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  # GET /vnfs/1
  # GET /vnfs/1.json
  def show
      render json: @vnf
  end

  swagger_api :create do
    summary "Create new VNF"
    param :form, :name, :string, :requiered, "Name"
    param :form, :cores, :integer, :requiered, "Cores"
    param :form, :ram, :integer, :requiered, "RAM"
    param :form, :disc, :integer, :requiered, "Disc"
    param :path, :network_service_id, :string, :requiered, "Network Service ID" 
    response :ok
    response :unauthorized
    response :not_acceptable
  end

  # POST /vnfs
  # POST /vnfs.json
  def create
      @network_service = NetworkService.find(params[:network_service_id])
      @vnf = @network_service.vnfs.new(vnf_params)
    if @vnf.save
        render json: @vnf
    else
        render json: {status: 'ERROR', data: @vnf.errors}
    end
  end

  swagger_api :update do |api|
    summary "Update a existed VNF"
    notes "Notes for updating a existed VNF"
    param :path, :id, :integer, :optional, "VNF ID"
    response :ok
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :unprocessable_entity
  end

  # PATCH/PUT /vnfs/1
  # PATCH/PUT /vnfs/1.json
  def update
    @network_service = NetworkService.find(params[:network_service_id])    
    @vnf = @network_service.vnfs.find(params[:id])  
    if @vnf.update(vnf_params)
        render json: @vnf
    else
        render json: {status: "ERROR", data: @vnf.error}
    end
  end

  swagger_api :destroy do
    summary "Delete VNF"
    param :path, :id, :integer, :required, "VNF ID"
    response :ok
    response :unauthorized
    response :not_found
  end

  # DELETE /vnfs/1
  # DELETE /vnfs/1.json
  def destroy
    @vnf.destroy
    render json: {status: "OK", message:"VNF deleted"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vnf
      @vnf = Vnf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vnf_params
      params.require(:vnf).permit(:name, :cores, :ram, :disc)
    end
end
