class User < ApplicationRecord

  has_secure_password
  has_many :items, dependent: :destroy
  has_many :shopping_lists, dependent: :destroy
  validates :email, uniqueness: true, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }, confirmation: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def mine?(object)
    id == object.user_id
  end
end
