class Api::V1::AlarmsController < ApplicationController
  before_action :set_alarm, only: [:show, :update, :destroy]

  swagger_controller :Alarms, "Alarms Management"

  swagger_api :index do
    summary "Fetches all Alarms"
    notes "This lists all Alarms"
    response :ok
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :request_range_not_satisfiable
  end

  # GET /alarms
  # GET /alarms.json
  def index
    render json: Alarm.all
  end

  swagger_api :show do
    summary "Show Alarm content"
    param :path, :id, :integer, :required, "Alarm ID"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  # GET /alarms/1
  # GET /alarms/1.json
  def show
    render json: @alarm
  end

  swagger_api :create do
    summary "Create new Alarm"
    param :form, :name, :string, :required, "Name"
    response :ok
    response :unauthorized
    response :not_acceptable
  end

  # POST /alarms
  # POST /alarms.json
  def create
    @alarm = Alarm.new(alarm_params)
    if @alarm.save
      render json: @alarm
    else
      render json: {status: 'ERROR', data: @alarm.errors}  
    end
  end

  swagger_api :update do
    summary "Update existing Alarm"
    notes "Update Alarm"
    param :path, :id, :integer, :required, "Alarm ID"
    param :form, :name, :string, :optional, "Name"
    response :ok
    response :unauthorized
    response :not_acceptable
  end

  # PATCH/PUT /alarms/1
  # PATCH/PUT /alarms/1.json
  def update
    if @alarm.update(alarm_params)
    	render json: @alarm
    else
    	render json: {status: 'ERROR', data: @alarm.errors}
    end
  end

  swagger_api :destroy do
    summary "Delete Alarm"
    param :path, :id, :integer, :required, "Alarm ID"
    response :ok
    response :unauthorized
    response :not_found
  end

  # DELETE /alarms/1
  # DELETE /alarms/1.json
  def destroy
    @alarm.destroy
    render json: {status: 'OK', message: 'Alarm deleted'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alarm
      @alarm = Alarm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alarm_params
      params.permit(:name)
    end
end
