class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :items, dependent: :destroy
  has_many :shopping_lists, dependent: :destroy
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, if: -> {new_record? ||changes[:crypted_password]}
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, length: {minimum: 3}, if: -> { new_record? || changes[:crypted_password]}
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def mine?(object)
    id == object.user_id
  end
end
