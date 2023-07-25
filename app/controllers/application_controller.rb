class ApplicationController < ActionController::Base

helper_method :current_user

private

  def current_user
    @current_user ||= User.find_by(id: user.session[:user_id])
  end
end
