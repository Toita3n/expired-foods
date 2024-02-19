require 'rails_helper'
require 'factory_bot_rails'

describe 'Sessions', type: :system do
  describe 'ユーザーログイン' do
    context '正常なフォーム入力' do
      it 'ログイン処理が成功する' do
        visit login_path
        user = create(:user, password: 'testpassword', password_confirmation: 'testpassword')
        login_as(user)
        expect(current_path).to eq items_path
        expect(page).to have_content 'ログインしました'
      end
    end

    context '未入力のフォーム' do
      it 'メールアドレスが不足している場合、ログイン処理が失敗する' do
        visit login_path
        user = create(:user, password: 'testpassword', password_confirmation: 'testpassword')
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'testpassword'
        find(".btn-login").click
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインに失敗しました'
      end

      it 'パスワードが不足している場合、ログイン処理が失敗する' do
        visit login_path
        user = create(:user, password: 'testpassword', password_confirmation: 'testpassword')
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        find(".btn-login").click
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインに失敗しました'
      end
    end
  end

  describe 'ゲストログインができる' do
    context 'ゲストユーザーが存在しない場合' do
      it 'ゲストログインの処理が成功する' do
        visit login_path
        click_link 'ゲストログイン'
        expect(current_path).to eq items_path
        expect(page).to have_content 'ゲストユーザーでログインしました。'
        expect(page).to have_content 'ゲストユーザーは機能を制限しています。'
      end
    end

    context 'ゲストユーザーが存在する場合' do
      before do
        visit login_path
        click_link 'ゲストログイン'
      end
      it 'ログイン後（ユーザー編集ができない）' do
        expect(page).to have_content 'ゲストユーザーでログインしました。'
        expect(page).to have_content 'ゲストユーザーは機能を制限しています。'
        expect(page).not_to have_content 'アカウント設定'
      end
    end
  end

  describe 'ログイン後' do
    it 'ユーザーのログアウトが成功する' do
      user = create(:user, password: 'testpassword', password_confirmation: 'testpassword')
      login_as(user)
      expect(page).to have_content 'ログインしました'
      expect(current_path).to eq items_path
      accept_confirm do
        click_on 'ログアウト'
      end
      expect(page).to have_content 'ログアウトしました'
      expect(current_path).to eq login_path
    end
  end
end
