class ShoppingListsController < ApplicationController
  before_action :set_shopping, only: %i[edit update]

  def index
    @shopping_lists = ShoppingList.where(user_id: current_user.id)
  end

  def new
    @shopping_list = ShoppingListCollectionForm.new
  end

  def create
    @shopping_list = ShoppingListCollectionForm.new(shopping_list_collection_params)
    if @shopping_list.save
      redirect_to shopping_lists_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def edit; end

  def update
    if @shopping_list.update(shopping_list_params)
      redirect_to shopping_lists_path, success: t('.success')
    else
      render :edit, danger: t('not_to_update')
    end
  end

  def destroy
    selected_shopping_list_ids = params[:selected_shopping_lists]

    if selected_shopping_list_ids.present?
      ShoppingList.where(id: selected_shopping_list_ids).destroy_all
      flash[:success] = t('.success')
    else
      flash[:warning] = t('.no_selection')
    end
    redirect_to shopping_lists_path
  end

  private

  def set_shopping
    @shopping_list = ShoppingList.find(params[:id])
  end

  def shopping_list_params
    params.require(:shopping_list).permit(:product, :number, :trait)
  end

  def shopping_list_collection_params
    params.require(:shopping_list_collection_form)
    .permit(shopping_lists_attributes: [:product, :number, :trait, :availability])
  end
end
