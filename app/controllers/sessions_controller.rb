class SessionsController < ApplicationController

  def create
    user = User.find_by(email: sessions_params[:email])
    if user&.authenticate(sessions_params[:password])
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
    params.permit(:email, :password)
  end
end
