class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    @sign_up_form = SignUpForm.new
  end

  def create
    @sign_up_form = SignUpForm.new(sign_up_form_params)
    if @sign_up_form.save
      redirect_to login_path, success: 'サインアップしました'
    else
      flash.now[:danger] = 'サインアップに失敗しました'
      render :new
    end
  end

  def destroy
    @users = User.find_by(id: params[:id])
    @user.destroy!
    redirect_to root_path
  end

  private

  def sign_up_form_params
    params.require(:sign_up_form).permit(:email, :password, :password_confirmation, :name)
  end
end
