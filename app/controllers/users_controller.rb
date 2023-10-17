class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create update destroy]

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
    @guest_user = guest_user
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
    params.require(:sign_up_form).permit(:name, :email, :password, :password_confirmation, :uid)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :reset_password_token, :uid)
  end
end
