class User < ApplicationRecord

  has_secure_password
  has_many :items, dependent: :destroy
  has_many :shopping_lists, dependent: :destroy
  has_one :profile
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 3 }, confirmation: true

  def mine?(object)
    id == object.user_id
  end
end
