class ApplicationController < ActionController::Base
  helper_method :current_user #теперь метод будет доступен во всех шаблонах

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
