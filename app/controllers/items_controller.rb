class ItemsController < ApplicationController

  def index
    if params[:latest_expired]
      @items = Item.latest_expired
    elsif params[:expired]
      @items = Item.expired
    else
      @items = Item.all
    end

    @tag_list = Tag.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @tags = Tag.find(params[:id])
  end

  def create
    @item = current_user.items.build(item_params)
    @item.user_id = current_user.id
    tag_list = params[:item][:name].split(' ')
    if @item.save
      @item.save_tags(tag_list)
      redirect_to items_path
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @tag_list = @item.tags.pluck(:name).join(' ')
  end

  def update
    @item = Item.find(params[:id])
    tag_list = params[:item][:name].split(' ')
    if @item.update(item_params)
      @item.save_tags(tag_list)
      redirect_to item_path(@item), success: 'アップデートされました'
    else
      remder :edit
    end
  end

  def destroy
    @item = Item.find_by(id: params[:id])
    @item.destroy!
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :count, :expired_at, :image, :image_cache, :tag_list)
  end
end
