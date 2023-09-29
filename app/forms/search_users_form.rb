class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string

  def search
    relation = User.distinct

    relation = relation.search_email(email) if email.present?

    relation
  end
end