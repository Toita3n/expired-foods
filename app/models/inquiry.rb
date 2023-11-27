class Inquiry < ApplicationRecord
  validates :email, presence: true
  validates :text, presence: true, length: { maximum: 1000 }
end
