class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to items_path
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
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
