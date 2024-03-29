class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :items, dependent: :destroy
  has_many :shopping_lists, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :name, uniqueness: true, presence: true, length: { maximum: 25 }
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  enum role: { general: 0, admin: 1 }

  scope :search_user_name, ->(name) { where("name LIKE :word", word: "%#{name}%") }
  scope :search_email, ->(email) { where("email LIKE :word", word: "%#{email}%") }

  validate :cannot_change_email, on: :update, if: -> { guest? && email_changed? }

  def cannot_change_email
    errors.add(:email, 'ゲストユーザーのemailは変更できません。')
  end

  def mine?(object)
    id == object.user_id
  end

  def guest?
    email == 'guestuser@example.com'
  end

  def self.guest
    find_or_initialize_by(email: 'guestuser@example.com') do |user|
      user.name = 'guest' if user.new_record?
      user.password = SecureRandom.hex(10) if user.new_record?
      user.password_confirmation = user.password if user.new_record?
      user.role = :general
      user.save! if user.new_record?
    end
  end
end
