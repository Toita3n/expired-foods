class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    @user = User.find_by(id: session[:user_id])
    
    if auth_params[:denied].present?
      redirect_to root_path, notice: 'ログインをキャンセルしました'
    elsif @user = login_from(provider)
      redirect_to root_path, notice: '連携できません'
    else
      if current_user.present?
        @user = update_from(provider)
      else
        @user = create_from(provider)
      end
      
      if @user
        redirect_to user_path(@user), notice: "#{provider.titleize}を連携しました"
      else
        redirect_to root_path, danger: 'ユーザーの作成に失敗しました'
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :denied, :state, :error)
  end

  def update_from(provider_name)
    sorcery_fetch_user_hash provider_name
    attrs = user_attrs(@provider.user_info_mapping, @user_hash)
    current_user.update(attrs.except(:name))
    current_user.add_provider_to_user(provider_name.to_s, @user_hash[:uid].to_s)
    authentication = current_user.authentications.find_by(provider: provider_name.to_s)
  end
end