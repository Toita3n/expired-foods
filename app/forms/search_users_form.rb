class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name,  :string
  attribute :email, :string

  def search
    relation = User.distinct

    relation = relation.search_user_name(name) if name.present?

    relation = relation.search_email(email) if email.present?

    relation
  end
end