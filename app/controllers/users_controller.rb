class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy show]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end
  
  def new
    redirect_to root_path, alert: 'You have already logged' if current_user.present?
    session[:current_time] = Time.now
    @user = User.new
  end
  
  def create
    redirect_to root_path, alert: 'You have already logged' if current_user.present?
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
  
  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.new
  end

  def destroy
    @user.destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'User deleted'
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end
  
  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password,
                                 :password_confirmation, :avatar_url)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
