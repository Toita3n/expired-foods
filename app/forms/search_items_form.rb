class SearchItemsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :detail, :string
  attribute :tag_name, :string
  attribute :user_id_item, :integer


  def search
    relation = Item.distinct

    relation = relation.search_title(title) if title.present?

    relation = relation.search_detail(detail) if detail.present?

    relation = relation.search_tag_name(tag_name) if tag_name.present?

    relation = relation.search_user_id_item(user_id_item) if user_id_item.present?

    relation
  end
end