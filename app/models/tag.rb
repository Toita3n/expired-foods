class Tag < ApplicationRecord
  has_many :item_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :items, through: :item_tags

  validates :name, uniqueness: true, presence: true

  scope :search_tag_name, ->(name) { where("name LIKE :word", word: "%#{name}%")}
end
