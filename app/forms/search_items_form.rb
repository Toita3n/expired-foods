class SearchItemsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :detail, :string
  attribute :tag_name, :string


  def search
    relation = Item.distinct

    relation = relation.search_title(title) if title.present?

    relation = relation.search_detail(detail) if detail.present?

    relation = relation.search_tag_name(tag_name) if tag_name.present?

    relation
  end
end