class Api::V1::NetworkServicesController < ApplicationController
  before_action :set_network_service, only: [:show, :update, :destroy]

  swagger_controller :NetworkServices, "Network Services Management"

  swagger_api :index do
    summary "Fetches all Network Services"
    notes "This lists all Network Services"
    response :ok
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :request_range_not_satisfiable
  end

  # GET /network_services
  # GET /network_services.json
  def index
      render json: NetworkService.all.to_json(:include => [:vnfs])
  end

  swagger_api :show do
    summary "Show Network Service content"
    param :path, :id, :integer, :requiere, "Network Service ID"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  # GET /network_services/1
  # GET /network_services/1.json
  def show
      render json: @network_service.to_json(:include => [:vnfs])
  end

  swagger_api :create do
    summary "Create new Network Service"
    param :form, :name, :string, :requiered, "Name"
    response :ok
    response :unauthorized
    response :not_acceptable
  end

  # POST /network_services
  # POST /network_services.json
  def create
    @network_service = NetworkService.new(network_service_params)
    if @network_service.save
      render json: @network_service
    else
        render json: {status: 'ERROR', message: 'Bad params', data: @network_service.error}
    end
  end

  swagger_api :update do
   summary "Update Network Service"
   param :path, :id, :integer, :requiered, "Network Service ID"
   param :form, :name, :string, :optional, "Name"
   response :ok
   response :unauthorized
   response :not_found
  end

  # PATCH/PUT /network_services/1
  # PATCH/PUT /network_services/1.json
  def update
    if @network_service.update(network_service_params)
        render json: @network_service
    else
    	render json: {status: 'ERROR', message: 'Bad params! {:name}', data: @network_service.errors}
    end
  end
  
  swagger_api :destroy do
    summary "Delete Network Service"
    param :path, :id, :integer, :required, "Network Service ID"
    response :ok
    response :unauthorized
    response :not_found
  end

  # DELETE /network_services/1
  # DELETE /network_services/1.json
  def destroy
    @network_service.destroy
    render json: {status: 'OK', message: 'Network Service deleted'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_service
      @network_service = NetworkService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_service_params
      params.permit(:name)
    end
end
