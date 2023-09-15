class ShoppingListsController < ApplicationController

  def index
    @shopping_lists = ShoppingList.all
  end

  def new
    @shopping_list = ShoppingList.new
  end

  def create
    @shopping_list = ShoppingList.new(shopping_list_params)
    @shopping_list.user_id = current_user.id #user_idをreferenceにしているため
    if @shopping_list.save
      redirect_to shopping_lists_path
    else
      render :new
    end
  end

  def edit
    @shopping_list = ShoppingList.find(params[:id])
  end

  def destroy
    @shopping_list = ShoppingList.find_by(id: params[:id])
    @shopping_list.destroy!
    redirect_to shopping_lists_path
  end

  private

  def shopping_list_params
    params.require(:shopping_list).permit(:product, :number, :trait)
  end
end
