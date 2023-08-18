class WishListsController < ApplicationController
  def index
    @wish_lists = Wish_list.find(params[:id])
  end
end
