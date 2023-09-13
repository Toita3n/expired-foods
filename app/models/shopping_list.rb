class ShoppingList < ApplicationRecord
  belongs_to :user
  validates :product, presence: true
  validates :number, presence: true
  validates :trait, presence: true, length: { minimum: 0, maximum: 256 }
end
