class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if auth_params[:denied].present?
      redirect_to root_path, success: "#{provider.titleize}でログインしました"
      return
    end
    create_user_form(provider) unless (@user = login_from(provider))
    redirect_to root_path, success: "#{provider.titleize}でログインしました"
  end

  private

  def auth_params
    params.permit(:code, :provider, :denied, :state)
  end

  def create_user_form(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
