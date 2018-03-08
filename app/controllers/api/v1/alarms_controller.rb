class Api::V1::AlarmsController < ApplicationController
  before_action :set_alarm, only: [:show, :update, :destroy]

  # GET /alarms
  # GET /alarms.json
  def index
      render json: Alarm.all
  end

  # GET /alarms/1
  # GET /alarms/1.json
  def show
    render json: @alarm
  end

  # POST /alarms
  # POST /alarms.json
  def create
    @alarm = @current_user.alarms.new(alarm_params)
    @vnf = Vnf.find(params[:vnf_id])
    @vnf.alarms << @alarm
    if @alarm.save
      render json: @alarm
    else
      render json: {status: 'ERROR', data: @alarm.errors}  
    end
  end

  # PATCH/PUT /alarms/1
  # PATCH/PUT /alarms/1.json
  def update
    @vnf = Vnf.find(params[:vnf_id])
    @alarm = @vnf.alarms.find(params[:id])
    if @alarm.update(alarm_params)
    	render json: @alarm
    else
    	render json: {status: 'ERROR', data: @alarm.errors}
    end
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
