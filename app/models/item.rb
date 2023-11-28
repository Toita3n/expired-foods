class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  attr_accessor :image_cache

  validates :title, presence: true
  validates :count, presence: true, numericality: true
  validates :expired_at, presence: true
  validates :detail, length: { minimum: 0, maximum: 256 }

  validate :check_guest_user_limit, if:-> { user&.guest? }

  scope :latest_expired, -> { order(expired_at: :desc) }
  scope :close_expired, -> { order(expired_at: :asc) }
  scope :search_title, ->(title) { where("title LIKE :word", word: "%#{title}%") }
  scope :search_detail, ->(detail) { where("detail LIKE :word", word: "%#{detail}%") }
  scope :search_user_id_item, ->(user_id_item) { where("user_id LIKE :word", word: "%#{user_id_item}%") }
  
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

  def check_guest_user_limit
    if user.guest? && user.items.count >= 3
      errors.add(:base, 'ゲストユーザーは3つまでしかアイテムを登録できません。')
    end
  end
end
