class Admin::TagsController < Admin::BaseController

  before_action :set_tag, only: %i[update show edit destroy]

  def index
    @tags = Tag.includes(items: :user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @tag_list = Tag.all
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
        redirect_to admin_tags_path, success: '商品が更新されました'
    else
        flash.now['danger'] = '更新できませんでした'
        render :edit
    end
  end

  def destroy
    @tag.destroy!
    redirect_to admin_tags_path, success: '削除完了しました'
  end

  def search
    @search_tags_form = SearchTagsForm.new(search_tag_params)
    @search_tags = @search_tags_form.search.order(created_at: :desc).page(params[:page]).per(20)
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

  def search_tag_params
    params.fetch(:q, {}).permit(:name)
  end
end
