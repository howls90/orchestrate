class Api::V1::VnfsController < ApplicationController
  before_action :set_vnf, only: [:show, :edit, :update, :destroy]

  # GET /vnfs
  # GET /vnfs.json
  def index
      render json: Vnf.all
  end

  # GET /vnfs/1
  # GET /vnfs/1.json
  def show
      render json: @vnf
  end

  # POST /vnfs
  # POST /vnfs.json
  def create
      @network_service = NetworkService.find(params[:network_service_id])
      @pop = Pop.find(params[:pop_id])
      @vnf = @network_service.vnfs.new(vnf_params)
      @current_user.vnfs << @vnf
      @pop.vnfs << @vnf
    if @vnf.save
        render json: @vnf
    else
        render json: {status: 'ERROR', data: @vnf.errors}
    end
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
      params.permit(:name, :cores, :ram, :disc)
    end
end
