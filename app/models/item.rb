class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  attr_accessor :image_cache
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  validates :title, presence: true
  validates :count, presence: true, numericality: true
  validates :expired_at, presence: true
  validates :detail, presence: true, length: { minimum: 0, maximum: 256}

  scope :latest_expired, -> { order(expired_at: :desc) }
  scope :expired, -> { order(expired_at: :asc) }

  def remaining_days
    today = Date.today
    expired_date = expired_at.to_date

    if expired_date == today
      '期限当日になりました'
    elsif expired_date < today
      '期限切れ'
    else
      remaining_days = (expired_date - today).to_i
      "あと #{remaining_days} 日です"
    end
  end

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(title: old_name)
    end

    new_tags.each do |new_name|
      new_item_tag = Tag.find_or_create_by(name: new_name)
      self.tags << new_item_tag
    end
  end
end
