class SessionsController < ApplicationController
  def new
    redirect_to root_path, alert: 'You have already logged' if current_user.present?
  end

  def create
    redirect_to root_path, alert: 'You have already logged' if current_user.present?
    user_params = params.require(:session)

    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])

    if user.present?
      session[:user_id] = user.id

      redirect_to root_path, notice: 'You are log in'
    else
      flash.now[:alert] = 'Uncorrect email or password'

      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: "You have logged out"
  end
end
