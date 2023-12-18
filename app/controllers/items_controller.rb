class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy increment decrement]

  def index
    @items = item_sort(params)
  end

  def already_expired
    @expired_items = current_user.items.already_expired.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @item = Item.new
  end

  def show
    @items = Item.select(:name).distinct
    respond_to do |format|
      format.html
      format.js # js形式で送信された場合はこちらが適応され、js.erbを探す
    end
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to items_path, success: t('.message_create')
    else
      render :new, danger: t('.not_to_create')
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), success: t('.message_item_update')
    else
      render :edit, danger: t('.not_to_update')
    end
  end

  def destroy
    @item.destroy!
    redirect_to items_path, success: t('.message_deleted')
  end

  def search
    @search_items_form = SearchItemsForm.new(search_item_params) #form_objectを使用してsearchする
    @search_items = @search_items_form.search.order(created_at: :desc).page(params[:page]).per(5)
  end

  def increment
    @item.increment!(:count)
    redirect_to items_path, success: t('.increase')
  end

  def decrement
    if @item.count > 0
      @item.decrement!(:count)
      redirect_to items_path, warning: t('.decrease')
    else
      redirect_to items_path, warning: t('.not_exceed_zero')
    end
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_sort(params)
    if params[:latest_expired]#賞味期限が遠い順
      current_user.items.latest_expired.page(params[:page]).per(5)
    elsif params[:close_expired]#賞味期限が遠い順
      current_user.items.close_expired.page(params[:page]).per(5)
    else
      current_user.items.close_expired.order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def item_params
    params.require(:item).permit(:title, :count, :expired_at, :detail)
  end

  def search_item_params
    params.fetch(:q, {}).permit(:title, :detail)
  end
end
