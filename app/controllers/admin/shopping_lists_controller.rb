class Admin::ShoppingListsController < Admin::BaseController
  before_action :set_shopping, only: %i[edit show destroy]

  def index
    @shopping_lists = ShoppingList.all.order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def show; end

  def destroy
    @shopping_list.destroy!
    redirect_to admin_shopping_lists_path, success: t('.success')
  end

  def search
    @search_shopping_lists_form = SearchShoppingListsForm.new(search_shopping_list_params)
    @search_shopping_lists = @search_shopping_lists_form.search.order(created_at: :desc).page(params[:page]).per(20)
  end

  private

  def set_shopping
    @shopping_list = ShoppingList.find(params[:id])
  end

  def shopping_list_params
    params.require(:shopping_list).permit(:product, :number, :trait, :user_email)
  end

  def search_shopping_list_params
    params.fetch(:q, {}).permit(:title, :detail, :user_email)
  end
end
