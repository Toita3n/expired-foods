class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  attr_accessor :image_cache
  attr_accessor :tag_name
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  validates :title, presence: true
  validates :count, presence: true, numericality: true
  validates :expired_at, presence: true
  validates :detail, length: { minimum: 0, maximum: 256}

  validate :check_guest_user_limit, if:-> { user&.guest? }

  scope :latest_expired, -> { order(expired_at: :desc) }
  scope :expired, -> { order(expired_at: :asc) }
  scope :search_title, ->(title) { where("title LIKE :word", word: "%#{title}%")}
  scope :search_detail, ->(detail) { where("detail LIKE :word", word: "%#{detail}%")}
  scope :search_tag_name, ->(tag_name) { joins(:tags).merge(Item.where("tags.name LIKE ?", "%#{tag_name}%"))}
  scope :search_user_id_item, ->(user_id_item) { where("user_id LIKE :word", word: "%#{user_id_item}%")}
  def remaining_days
    today = Date.today
    expired_date = expired_at.to_date

    if expired_date == today
      '期限当日です'
    elsif expired_date < today
      '期限切れです'
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
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      new_item_tag = Tag.find_or_create_by(name: new_name)
      self.tags << new_item_tag
    end
  end

  def check_guest_user_limit
    if user.guest? && user.items.count >= 3
      errors.add(:base, 'ゲストユーザーは3つまでしかアイテムを登録できません。')
    end
  end
end
