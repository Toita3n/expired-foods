require 'rails_helper'

describe '商品一覧機能', type: :system do
  describe '一覧表示機能' do
      before do
          user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'tester@example.com')
          FactoryBot.create(:item, title: '最初の商品', user: :user_a)
      end

      context 'ユーザーAがログインしている時' do
          before do
              visit login_path
              fill_in 'メールアドレス', with: 'tester@example.com'
              fill_in 'パスワード', with: 'testpassword'
              click_button 'ログイン'
          end

          it 'ユーザーAが作成した商品が表示される' do
              expect(page).to have_content '最初の商品'
          end
      end
  end
end