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

    @user = login_from(provider)

    if @user
      if @user.uid != auth_params[:uid] # ユーザーがログインしようとしているUIDと異なる場合
        # 既存ユーザーのUIDを更新
        @user.update(uid: auth_params[:uid])
      end
      redirect_to current_user_path(@user), success: "#{provider.titleize}でログインしました"
    else
      # 新しいユーザーを作成
      @user = create_from(provider)
      # LINEのUIDを新しいユーザーアカウントに関連付ける
      @user.update(uid: auth_params[:uid])
      redirect_to root_path
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :denied, :state, :uid)
  end
end