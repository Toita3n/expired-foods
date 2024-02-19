require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:user_a) do 
    FactoryBot.create(
    :user,
    name: 'testuserSAS',
    email: 'testusersas@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
  end
  describe 'associations' do
    it 'ユーザーとItemの結びつき' do
      item = Item.reflect_on_association(:user) #ユーザー(:user)に関する情報を取得
      expect(item.macro).to eq(:belongs_to) #1:Nでモデルとの関係ができている
    end #上の二つを合わせると expect((item).reflect_on_association(:user).macro).to eq :belongs_to
  end

  describe '商品・食材のvalidation' do
    it '商品・食材にtitle, count, expired_at, detailがある場合有効' do
      item = Item.new(
        title: 'ファインダー',
        count: 1,
        expired_at: 4.weeks.from_now,
        detail: 'dog&cat',
        user_id: user_a.id,
      )
      expect(item).to be_valid #商品・食材が有効
    end

    it '商品名(title)が存在しないため無効' do
      item = FactoryBot.build(:item, title: nil)
      item.valid?
      expect(item.errors[:title]).to include("を入力してください")
    end

    it '総数（count）が存在しないため無効' do
      item = FactoryBot.build(:item, count: nil)
      item.valid?
      expect(item.errors[:count]).to include("を入力してください", "は数値で入力してください")
    end

    it '賞味期限(expired_at)が存在しないため無効' do
      item = FactoryBot.build(:item, expired_at: nil)
      item.valid?
      expect(item.errors[:expired_at]).to include("を入力してください")
    end

    it '詳細(detail)は0以上256文字以内でないと無効' do
      item = FactoryBot.build(:item, detail: 'abc' * 200 )
      item.valid?
      expect(item.errors[:detail]).to include("は256文字以内で入力してください")
    end
  end
end
