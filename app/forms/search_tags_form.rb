class SearchTagsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  def search
    relation = Tag.distinct

    relation = relation.search_tag_name(name) if name.present?

    relation
  end
end