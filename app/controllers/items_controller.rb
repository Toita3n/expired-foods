class ItemsController < ApplicationController

  def index
    if params[:latest_expired]
      @items = Item.latest_expired.page(params[:page]).per(5)
    elsif params[:expired]
      @items = Item.expired.page(params[:page]).per(5)
    else
      @items = Item.all.page(params[:page]).per(5)
    end

    @tag_list = Tag.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.select(:name).distinct
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
      render :edit
    end
  end

  def destroy
    @item = Item.find_by(id: params[:id])
    @item.destroy!
    redirect_to items_path
  end

  def search
    @search_items_form = SearchItemsForm.new(search_item_params)
    @search_items = @search_items_form.search.order(created_at: :desc).page(params[:page]).per(5)
  end

  private

  def item_params
    params.require(:item).permit(:title, :count, :expired_at, :image, :image_cache, :tag_list, :detail)
  end

  def search_item_params
    params.fetch(:q, {}).permit(:title, :detail, :tag_name)
  end
end
