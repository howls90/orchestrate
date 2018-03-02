class Api::V1::PopsController < ApplicationController
  before_action :set_pop, only: [:show, :edit, :update, :destroy]

  swagger_controller :Pop, "Point of Presence Management"

  swagger_api :index do
      summary "Fetches all PoPs"
      notes "This lists all PoPs"
      response :unauthorized
      response :not_acceptable, "The request you made is not acceptable"
      response :request_range_not_satisfiable
  end

  # GET /pops
  # GET /pops.json
  def index
    render json: Pop.all
  end

  swagger_api :show do
    summary "Show PoP content"
    param :path, :id, :integer, :optional, "PoP id"
    response :ok, "Success", :Pop
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  # GET /pops/1
  # GET /pops/1.json
  def show
    render json: @pop
  end

  swagger_api :create do
    summary "Create new Point of Presence"
    notes "Create Point of Presence"
    param :form, :name, :string, :required, "Name"
    response :ok
    response :unauthorized
    response :not_acceptable
  end

  # POST /pops
  # POST /pops.json
  def create
    @pop = Pop.new(pop_params)
    if @pop.save
      render json: @pop
    else
        render json: {status: 'ERROR', data: @pop.errors}
    end
  end

  swagger_api :update do
    summary "Update existing Point of Presence"
    notes "Update Point of Presence"
    param :form, :name, :string, :required, "Name"
    response :ok
    response :unauthorized
    response :not_acceptable
  end

  # PATCH/PUT /pops/1
  # PATCH/PUT /pops/1.json
  def update
    if @pop.update(pop_params)
      render json: @pop
    else
      render json: {status: 'ERROR', data: @pop.errors}
    end
  end

  swagger_api :destroy do
    summary "Delete an existing Pop"
    param :path, :id, :integer, :required, "PoP ID"
    response :ok
    response :unauthorized
    response :not_found
  end

  # DELETE /pops/1
  # DELETE /pops/1.json
  def destroy
    @pop.destroy
    render json: {status: 'OK', message: 'Pop deleted'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pop
      @pop = Pop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pop_params
      params.require(:pop).permit(:name, :ip, :instance)
    end
end
