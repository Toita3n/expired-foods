require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
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
    it 'ユーザーとshopping_listの結びつき' do
      shopping_list = ShoppingList.reflect_on_association(:user)
      expect(shopping_list.macro).to eq(:belongs_to)
    end
  end

  describe '買い物リストのvalidations' do
    it '買い物リストにproduct, number, traitが入る場合有効' do
      shopping_list = ShoppingList.new(
        product: 'レトルトカレー',
        number: 1,
        trait: '詳しい内容',
        user_id: user_a.id,
      )
      expect(shopping_list).to be_valid #買い物リストが有効
    end

    it '商品名(product)が入っていないため無効' do
      shopping_list = FactoryBot.build(:shopping_list, product: nil)
      shopping_list.valid?
    end

    it '総数(number)が入っていないため無効' do
      shopping_list = FactoryBot.build(:shopping_list, number: nil)
      shopping_list.valid?
    end

    it 'メモ(trait)は0以上30文字以内でないと無効' do
      shopping_list = FactoryBot.build(:shopping_list, trait: 'abc' * 12 )
      shopping_list.valid?
      expect(shopping_list.errors[:trait]).to include("は30文字以内で入力してください")
    end
  end
end
