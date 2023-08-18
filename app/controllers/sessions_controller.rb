class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to items_path
   else
      render :new
   end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, success: 'ログアウトしました'
  end

  private

  def sessions_params
    params.require(:session).permit(:email, :password)
  end
end
