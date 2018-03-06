class Api::Testing::ScenariosController < TestingController
  before_action :set_scenario, only: [:show, :destroy, :update]

  swagger_controller :Scenarios, "Area of coverage"

  swagger_api :index do
    summary "Fetches all Scenarios"
    notes "This lists all Scenarios"
    response :ok
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end      
  
  def index
      render json: Scenario.all.to_json(:include => [:rrhs])
  end

  swagger_api :show do
    summary "Show Scenario content"
    param :path, :id, :integer, :requiere, "Scenario ID"
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
  
  def show
      puts @scenario.rrhs
      render json: @scenario.to_json( :include => [:rrhs] )
  end

  swagger_api :create do
    summary "Create new Scenario"
    param :form, :name, :string, :required, "Name"
    response :ok
    response :unauthorized
    response :not_acceptable
  end
  
  def create
    @scenario = Scenario.new(scenario_params)
    if @scenario.save
      render json: @scenario
    else
      render json: {status: 'ERROR', data: @scenario.errors}
    end
  end
  
  swagger_api :destroy do
    summary "Deletes an existing Scenario"
    param :path, :id, :integer, :required, "Scenario ID"
    response :ok
    response :unauthorized
    response :not_found
  end
  
  def destroy
    @scenario.destroy
    render json: {status: 'OK', message: 'Scenario deleted'}
  end

  swagger_api :update do
    summary "Update Scenario"
    notes "Update Scenario"
    param :form, :name, :string, :required, "Name"
    response :ok
    response :unauthorized
    response :not_acceptable
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
