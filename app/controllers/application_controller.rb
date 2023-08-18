class ApplicationController < ActionController::Base

  helper_method :current_user
  before_action :require_login
  
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect_to login_path, warning: 'ログインしてください' if current_user.blank?
  end
end
