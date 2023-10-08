class GuestSessionsController < ApplicationController
  skip_before_action :require_login
  def create
    user = User.guest
    session[:user_id] = user.id
    flash[:success] = t('.guest_user_login')
    flash[:warning] = t('.limited_function')
    redirect_to items_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: t('.logout_guest_user')
  end
end
