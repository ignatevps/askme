class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  
    if @user.save
      redirect_to root_path, notice: 'You have successfully registered'
    else
      flash.now[:alert] = 'The registration form is filled out incorrectly'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'User data has been updated'
    else
      flash.now[:alert] = 'An error occurred when trying to save a user'
    
      render :edit
    end
  end

  def destroy
    @user.destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'User deleted'
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
