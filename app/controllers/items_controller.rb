class ItemsController < ApplicationController

  def index
    if params[:latest_expired] #賞味期限が遠い順
      @items = Item.latest_expired.page(params[:page])
    elsif params[:expired] #賞味期限が遠い順
      @items = Item.expired.page(params[:page])
    else
      @items = Item.all.order(created_at: :asc).page(params[:page])
    end
    @tag_list = Tag.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.select(:name).distinct
    @tags = Tag.all
  end

  def create
    @item = current_user.items.build(item_params)
    tag_list = params[:item][:tag_name].split(' ') #tagの表示
    if @item.save
      @item.save_tags(tag_list)
      redirect_to items_path, success: t('.message_create')
    else
      render :new, danger: t('.not_to_create')
    end
  end

  def edit
    @item = Item.find(params[:id])
    @tag_list = @item.tags.pluck(:name).join(' ') #半角空白でtagを追加できる
  end

  def update
    @item = Item.find(params[:id])
    tag_list = params[:item][:tag_name].split(' ')
    if @item.update(item_params)
      @item = Item.find(params[:id])
      @item.save_tags(tag_list)
      redirect_to item_path(@item), success: t('.message_item_update')
    else
      render :edit, danger: t('.not_to_update')
    end
  end

  def destroy
    @item = Item.find_by(id: params[:id])
    @item.destroy!
    redirect_to items_path, success: t('.message_deleted')
  end

  def search
    @search_items_form = SearchItemsForm.new(search_item_params) #　form_objectを使用してsearchする
    @search_items = @search_items_form.search.order(created_at: :desc).page(params[:page]).per(5)
  end

  private

  def item_params
    params.require(:item).permit(:title, :count, :expired_at, :image, :image_cache, :tag_list, :tag_name, :detail)
  end

  def search_item_params
    params.fetch(:q, {}).permit(:title, :detail, :tag_name)
  end
end
