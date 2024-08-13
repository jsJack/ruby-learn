class UsersController < ApplicationController
  before_action :user, only: %i[show edit update destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    # Nothing else needed here seen as I already have @user from the before_action
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to '/', warning: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/1/edit
  def edit
    # Nothing else needed here seen as I already have @user from the before_action
  end

  # PATCH /users/1
  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Private methods
  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end

  def user
    @user = User.find(params[:id])
  end
end
