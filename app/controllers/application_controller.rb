class ApplicationController < ActionController::Base
  # now the method will be available in all templates
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user
    redirect_to root_path, alert: 'No access rights'
  end
end
