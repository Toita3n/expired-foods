class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @tags = Tag.includes(items: :user).page(params[:page]).per(5)
    @items = Item.includes(:user).page(params[:page]).per(5)
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to tags_path
  end
end
