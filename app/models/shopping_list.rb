class ShoppingList < ApplicationRecord
  belongs_to :user
  validates :product, presence: true
  validates :number, presence: true
  validates :trait, length: { minimum: 0, maximum: 256 }

  scope :search_product, ->(product) { where("product LIKE :word", word: "%#{product}%")}
  scope :search_trait, ->(trait) { where("trait LIKE :word", word: "%#{trait}%")}
  scope :search_user_email, ->(user_email) {joins(:user).where("users.email LIKE ?", "%#{user_email}%")}
end
