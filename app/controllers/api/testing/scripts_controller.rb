class Api::Testing::ScriptsController < TestingController
  before_action :set_script, only: [:show, :edit, :update, :destroy]

  swagger_controller :Scripts, "Provision scripts Management"

  swagger_api :index do
    summary "Fetches all Scripts"
    notes "This lists all the Scripts"
    response :ok
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end

  # GET /scripts
  # GET /scripts.json
  def index
    render json: Script.all
  end

  swagger_api :show do
    summary "Show Script content"
    param :path, :id, :integer, :required, "Script ID"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  # GET /scripts/1
  # GET /scripts/1.json
  def show
    render json: @script
  end

  swagger_api :create do
    summary "Create new Scenario"
    notes "Create Scripts"
    param :form, :name, :string, :required, "Name"
    param :form, :provider, :string, :required, "Provider"
    response :ok
    response :unauthorized
    response :not_acceptable
  end

  # POST /scripts
  # POST /scripts.json
  def create
    @script = Script.new(script_params)
    if @script.save
      render json: @script 
    else
      render json: {status: 'ERROR', message: 'Bad params! {:name}', data: @script.errors}
    end
  end

  swagger_api :update do
    summary "Update Script"
    notes "Update Scripts"
    param :form, :name, :string, :required, "Name"
    param :form, :provider, :string, :required, "Provider"
    response :ok
    response :unauthorized
    response :not_acceptable
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

  swagger_api :destroy do
    summary "Deletes an existing Script"
    param :path, :id, :integer, :required, "Script ID"
    response :ok
    response :unauthorized
    response :not_found
  end

  # DELETE /scripts/1
  # DELETE /scripts/1.json
  def destroy
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
      params.permit(:name, :provider)
    end
end
