class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create update destroy]
  before_action :set_user, only: %i[edit update]

  def new
    @sign_up_form = SignUpForm.new
  end

  def create
    @sign_up_form = SignUpForm.new(sign_up_form_params) #form_objectを使用してユーザー登録
    if @sign_up_form.save
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def show
    set_current_user
    @authentication = current_user.authentications.find_by(provider: 'line')
  end

  def edit;end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), success: t('.success')
    else
      render :edit, danger: t('.not_to_update')
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy!
    redirect_to root_path, success: t('.success')
  end

  private

  def sign_up_form_params
    params.require(:sign_up_form).permit(:name, :email, :password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :reset_password_token, :uid)
  end

  def set_user
    @user = User.find(id: params[:id])
  end

  def set_current_user
    @current_user = User.find(current_user.id)
  end
end
