require 'rails_helper'

RSpec.describe "買い物リスト", type: :system do
  let(:user_a) { FactoryBot.create(:user, password: 'testpassword', password_confirmation: 'testpassword')}
  let(:user_b) { FactoryBot.create(:user, password: 'testpassword', password_confirmation: 'testpassword')}
  let!(:shopping_list_c) { FactoryBot.create(:shopping_list, product: 'そば', number: '1', trait: 'expensive_food', user: user_a )}
  before do
    FactoryBot.create(:shopping_list, product: '最初の商品', number: '2', trait: 'test_place', user: user_a )
    visit login_path
    fill_in 'メールアドレス', with: user_a.email
    fill_in 'パスワード', with: user_a.password
    find(".btn-login").click
  end
  describe '買い物リスト/index' do
    before { login_as(user_a); list_register(shopping_list_c) }
    it 'Shopping_lists/indexに商品(そば)が表示される' do
      visit shopping_lists_path
      expect(page).to have_content 'そば'
      expect(page).to have_content '1'
      expect(page).to have_content 'expensive_food'
    end

    it '商品がモーダルで編集できる' do
      visit shopping_lists_path
      find('.list-modal-trigger', match: :first).click
      fill_in '商品名', with: '買い物リスト2'
      fill_in '総数', with: '3'
      fill_in 'メモ', with: '買い物メモ'
      click_on '更新'
      visit shopping_lists_path
      expect(page).to have_content '買い物リスト2'
      expect(page).to have_content '3'
      expect(page).to have_content '買い物メモ'
    end

    it '商品を削除できる' do
      visit shopping_lists_path
      all('input[name="selected_shopping_lists[]"]').each do |checkbox|
        checkbox.check
      end
      click_button 'チェック済みを削除'
      expect(page).to have_content '買い物リストから商品を削除しました'
    end
  end

  describe '買い物リストに新しく商品を登録できる' do
    before { login_as(user_a) }
    context '登録フォームが正常に入ってない時' do
      it '商品名がないため買い物リストに表示されない' do
        visit new_shopping_list_path
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][product]', with: ''
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][number]', with: '99'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][trait]', with: '商品名ない'
        click_button '買い物リストに登録'
        expect(current_path).to eq shopping_lists_path
        expect(page).not_to have_content '99'
        expect(page).not_to have_content '商品名ない'
      end

      it '総数がないため買い物リストに表示されない' do
        visit new_shopping_list_path
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][product]', with: '総数なし'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][number]', with: nil
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][trait]', with: '数がない'
        click_button '買い物リストに登録'
        expect(current_path).to eq shopping_lists_path
        expect(page).not_to have_content '総数なし'
        expect(page).not_to have_content '数がない'
      end
    end

    context '登録フォームが正常にないっている' do
      it '買い物リストに登録できる' do
        visit new_shopping_list_path
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][product]', with: 'うどん'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][number]', with: '11'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][trait]', with: '冷凍'
        click_button '買い物リストに登録'
        expect(current_path).to eq shopping_lists_path
        expect(page).to have_content 'うどん'
        expect(page).to have_content '11'
        expect(page).to have_content '冷凍'
        expect(page).to have_content '商品がショッピングリストに追加されました(商品名、総数が入ってない場合は表示されません)'
      end

      it '買い物リストに複数登録できる' do
        visit new_shopping_list_path
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][product]', with: 'ニラ'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][number]', with: '97'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][0][trait]', with: '東京産'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][1][product]', with: 'ポルチーニ'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][1][number]', with: '98'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][1][trait]', with: 'イタリア産'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][2][product]', with: '単三電池'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][2][number]', with: '95'
        fill_in 'shopping_list_collection_form[shopping_lists_attributes][2][trait]', with: 'エネループ'
        click_button '買い物リストに登録'
        expect(current_path).to eq shopping_lists_path
        expect(page).to have_content 'ニラ'
        expect(page).to have_content '97'
        expect(page).to have_content '東京産'
        expect(page).to have_content 'ポルチーニ'
        expect(page).to have_content '98'
        expect(page).to have_content 'イタリア産'
        expect(page).to have_content '単三電池'
        expect(page).to have_content '95'
        expect(page).to have_content 'エネループ'
        expect(page).to have_content '商品がショッピングリストに追加されました(商品名、総数が入ってない場合は表示されません)'
      end
    end
  end
end
