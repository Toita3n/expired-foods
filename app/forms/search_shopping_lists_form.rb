class SearchShoppingListsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :product, :string
  attribute :trait, :string
  attribute :user_email, :string

  def search
    relation = ShoppingList.distinct

    relation = relation.search_product(product) if product.present?

    relation = relation.search_trait(trait) if trait.present?

    relation = relation.search_user_email(user_email) if user_email.present?

    relation
  end
end