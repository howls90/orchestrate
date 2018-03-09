class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
      render json: User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: {status: 'ERROR', data: @user.errors}  
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    	render json: @user
    else
    	render json: {status: 'ERROR', data: @user.errors}
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    render json: {status: 'OK', message: 'User deleted'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
