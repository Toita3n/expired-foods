class SignUpForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :email, :string
  attribute :password, :string
  attribute :password_confirmation, :string

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  with_options presence: true do
    validates :email, :password, :password_confirmation
  end

  def save
    return false unless valid?

    user = User.new(email: email, password: password, password_confirmation: password_confirmation)
    user.save!
  end

  def user
    @user ||= User.new(email: email, password: password, password_confirmation: password_confirmation)
  end
end