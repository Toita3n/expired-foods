require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe 'お問い合わせのvalidation' do
    it 'お問い合わせにemail, textがある場合有効' do
      inquiry = Inquiry.new(
        email: 'test@testexample.com',
        text: 'テストですよろしくお願いします。',
      )
      expect(inquiry).to be_valid
    end
    it 'メールアドレス(email)が存在しないため無効' do
      inquiry = FactoryBot.build(:inquiry, email: nil)
      inquiry.valid?
      expect(inquiry.errors[:email]).to include("を入力してください")
    end

    it '本文(text)が存在しないため無効' do
      inquiry = FactoryBot.build(:inquiry, text: nil)
      inquiry.valid?
      expect(inquiry.errors[:text]).to include("を入力してください")
    end
  end
end
