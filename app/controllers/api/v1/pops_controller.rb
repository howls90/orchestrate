class Api::V1::PopsController < ApplicationController
  before_action :set_pop, only: [:show, :edit, :update, :destroy]

  # GET /pops
  # GET /pops.json
  def index
      render json: Pop.all.to_json(:include => [:vnfs])
  end

  # GET /pops/1
  # GET /pops/1.json
  def show
      render json: @pop.to_json(:include => [:vnfs])
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

  # PATCH/PUT /pops/1
  # PATCH/PUT /pops/1.json
  def update
    if @pop.update(pop_params)
      render json: @pop
    else
      render json: {status: 'ERROR', data: @pop.errors}
    end
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
