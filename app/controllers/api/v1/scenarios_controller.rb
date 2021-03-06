require 'json'

class Api::V1::ScenariosController < ApplicationController
  before_action :set_scenario, only: [:show, :destroy, :update]
  
  def index
      render json: Scenario.all.to_json(:include => [:rrhs])
  end

  def show
      render json: @scenario.to_json( :include => [:rrhs])
  end

  def create
    scenario = Scenario.new(scenario_params)
    if scenario.save
      render json: scenario
    else
      render json: {status: 'ERROR', data: scenario.errors}
    end
  end
  
  def destroy
    @scenario.destroy
    render json: {status: 'OK', message: 'Scenario deleted'}
  end

  # PATCH/PUT /scripts/1
  # PATCH/PUT /scripts/1.json
  def update
    if @scenario.update(scenario_params)
    	render json: @scenario
    else
    	render json: {status: 'ERROR', data: @scenario.errors}
    end
  end

  private
    def scenario_params
      params.permit(:name)
    end

    def set_scenario
      @scenario = Scenario.find(params[:id])
    end
end
