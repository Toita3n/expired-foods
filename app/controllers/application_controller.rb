require 'line/bot'

class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :not_authenticated
  before_action :require_login
  add_flash_types :success, :info, :warning, :danger

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def not_authenticated
    redirect_to login_path, danger: t('defaults.message.not_authorized')
  end
  
  def guest_user
    current_user == User.find_by(email: 'guestuser@example.com')
  end
end
