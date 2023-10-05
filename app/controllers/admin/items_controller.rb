class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: %i[edit update show destroy]

  def index
    @items = Item.all.order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def update
    @item = Item.find(params[:id])
    tag_list = params[:item][:tag_name].split(' ')
    if  @item.update(item_params)
        @item.save_tags(tag_list)
        redirect_to admin_item_path(@item), success: t('.message_item_update')
    else
        flash.now['danger'] = t('.not_to_update')
        render :edit
    end
  end

  def show; end

  def destroy
    @item.destroy!
    redirect_to admin_item_path, success: t('.message_deleted')
  end

  def search
    @search_items_form = SearchItemsForm.new(search_item_params)
    @search_items = @search_items_form.search.order(created_at: :desc).page(params[:page]).per(20)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :count, :expired_at, :image, :image_cache, :tag_list, :tag_name, :detail)
  end

  def search_item_params
    params.fetch(:q, {}).permit(:title, :detail, :tag_name, :email_item)
  end
end
