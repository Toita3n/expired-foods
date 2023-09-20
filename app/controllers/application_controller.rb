class ApplicationController < ActionController::Base

  helper_method :current_user
  before_action :require_login
  
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def not_authenticated
    redirect_to login_path, danger: "ログインして下さい"
  end
end
