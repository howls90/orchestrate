class Api::V1::ScriptsController < ApplicationController
  before_action :set_script, only: [:show, :destroy, :update]

  # GET /scripts
  # GET /scripts.json
  def index
    render json: Script.all
  end

  # GET /scripts/1
  # GET /scripts/1.json
  def show
    render json: @script
  end

  # POST /scripts
  # POST /scripts.json
  def create
    @script = @current_user.scripts.new(script_params)
    if @script.save
      render json: @script 
    else
      render json: {status: 'ERROR', message: 'Bad params! {:name}', data: @script.errors}
    end
  end

  # PATCH/PUT /scripts/1
  # PATCH/PUT /scripts/1.json
  def update
    if @script.update(script_params)
      render json: @script
    else
      render json: {status: 'ERROR', data: @script.errors}
    end
  end

  # DELETE /scripts/1
  # DELETE /scripts/1.json
  def destroy
    puts "eeeeee#{@script}"
    @script.destroy
    render json: {status: 'OK', message: 'Script deleted'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_script
      @script = Script.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def script_params
      params.permit(:name, :provider, :configuration)
    end
end
