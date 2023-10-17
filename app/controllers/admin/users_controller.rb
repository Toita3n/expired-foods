class Admin::UsersController < Admin::BaseController
  before_action :set_user, only:  %i[edit update show destroy]

  def index
    @users = User.all.order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def update
    if @user.update(user_params)
       redirect_to admin_user_path(@user), success: t('defaults.message.updated', item: User.model_name.human)
    else
       flash.now[:danger] = t('.fail')
       render :edit
    end
  end
  def show; end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: t('defaults.message.deleted', item: User.model_name.human)
  end

  def search
    @search_users_form = SearchUsersForm.new(search_email_params)
    @search_users = @search_users_form.search.order(created_at: :desc).page(params[:page]).per(20)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end

  def search_email_params
    params.fetch(:q, {}).permit(:user, :email)
  end
end
