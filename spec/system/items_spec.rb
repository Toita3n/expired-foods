require 'rails_helper'

describe '冷蔵庫の中身の一覧機能', type: :system do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  describe 'ログイン前' do
    describe  'ページ移行確認' do
      context '食材・商品の新規登録' do
        it '食材・商品の新規登録ページにアクセスが失敗' do
          visit new_item_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context '商品・食材編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
            visit edit_item_path(item)
            expect(page).to have_content('ログインしてください')
            expect(current_path).to eq item_path(item)
        end
      end
    end

  describe 'モーダル表記の表示確認' do
    context '商品・食材がモーダル表記の詳細ページにアクセス' do
      it '商品・食材の詳細ページが表示される', js: true do
          find(".")
          click item.title
          expect

    end

  describe 'ログイン後' do
      before { login_as(user) }

      describe '商品・食材の新規登録' do
        context 'フォームの入力値が正常' do
          it '商品・食材の新規作成が成功する' do
            visit new_item_path
            fill_in '商品名', with: 'test_item_title'
            fill_in '数', with: '22'
            fill_in '賞味期限', with: DateTime.new(2030, 2, 2)
            fill_in 'item[detail]', with: 'test-test-test'
            click_button '登録'
            except(page).to have_content 'test_item_title'
            except(page).to have_content '22'
            except(page).to have_content DateTime.new(2030, 2, 2)
          end

          it '食材テンプレートの使用が成功する' do
            visit new_item_path
            fill_in '賞味期限', with: DateTime.new(2030, 5, 5)
            click_button
          it 'ユーザーが作成した商品が表示される' do
              expect(page).to have_content '最初の商品'
          end
      end
  end
end