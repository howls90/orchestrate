class Api::V1::NetworkServicesController < ApplicationController
  before_action :set_network_service, only: [:show, :update, :destroy]

  # GET /network_services
  # GET /network_services.json
  def index
      render json: NetworkService.where(user_id: @current_user).to_json(:include => [:vnfs])
  end

  # GET /network_services/1
  # GET /network_services/1.json
  def show
      render json: @network_service.to_json(:include => [:vnfs])
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

  # PATCH/PUT /network_services/1
  # PATCH/PUT /network_services/1.json
  def update
    if @network_service.update(network_service_params)
        render json: @network_service
    else
    	render json: {status: 'ERROR', message: 'Bad params! {:name}', data: @network_service.errors}
    end
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
