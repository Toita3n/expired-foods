require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ユーザー関連' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの値が未入力' do
          it 'ユーザーの新規作成の失敗' do
            visit sign_up_path
            fill_in 'アカウント名', with: 'TesterA'
            fill_in 'メールアドレス', with: nil
            fill_in 'パスワード', with: 'testpass'
            fill_in 'パスワード再確認用', with: 'testpass'
            click_button 'アカウントを作成する'
            expect(current_path).to eq sign_up_path
            expect(page).to have_content 'アカウントの作成に失敗しました'
          end
        end

        context 'フォームの値が正常' do
          it 'ユーザーの新規作成の成功' do
            visit sign_up_path
            fill_in 'アカウント名', with: 'TesterA'
            fill_in 'メールアドレス', with: 'testa@example.com'
            fill_in 'パスワード', with: 'testpass'
            fill_in 'パスワード再確認用', with: 'testpass'
            click_button 'アカウントを作成する'
            expect(current_path).to eq login_path
          end
        end

        context '登録済みのメールアドレス' do
          it 'メールアドレスが登録済みの場合での作成失敗' do
            visit sign_up_path
            name = Faker::Name.name
            email = Faker::Internet.email
            user = create(:user, name: name, email: email, password: 'pass', password_confirmation: 'pass')
            user2 = build(:user, name: name, email: email, password: 'pass', password_confirmation: 'pass')
            user2.valid?
            expect(current_path).to eq sign_up_path
          end
        end
      end
    end

    describe 'ログイン後' do
      describe '(profile)ユーザー編集' do
        describe 'メールアドレスの編集' do
          context 'フォームの値が未入力' do
            it 'メールアドレスの変更失敗' do
              user = create(:user, password: 'testpassword', password_confirmation: 'testpassword')
              login_as(user)
              visit profile_path
              click_on 'メールアドレスの変更'
              expect(current_path).to eq edit_profile_path
              fill_in 'メールアドレス', with: nil
              click_on '変更'
              expect(current_path).to eq profile_path
              expect(page).to have_content 'ユーザーを更新できませんでした'
            end
          end

          context 'フォームの値が正常' do
            it 'メールアドレスの変更が成功' do
              user = create(:user, password: 'testpassword', password_confirmation: 'testpassword')
              login_as(user)
              visit profile_path
              click_on 'メールアドレスの変更'
              expect(current_path).to eq edit_profile_path
              fill_in 'メールアドレス', with: 'testab@example.com'
              click_on '変更'
              expect(current_path).to eq profile_path
              expect(page).to have_content 'ユーザーを更新しました'
            end
          end
        end

        describe 'ユーザーの削除' do
          context 'ユーザーのアカウントの削除' do
            it 'ボタンを押して削除' do
              user = create(:user, password: 'testpassword', password_confirmation: 'testpassword')
              login_as(user)
              visit profile_path
              click_link 'アカウント削除'
              expect(page.accept_confirm).to eq '削除しますか？'
              expect(page).to have_content 'アカウントを削除しました'
              expect(current_path).to eq root_path
            end
          end
        end
      end
    end
  end
end
