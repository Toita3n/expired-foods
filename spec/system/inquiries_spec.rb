require 'rails_helper'

RSpec.describe "Inquiries", type: :system do
  before do
    FactoryBot.build(:inquiry, email: 'test@testexample.com', text: 'test-text-word')
  end

  context 'お問い合わせが送信できる' do
    it 'フォームを正しく入力してお問い合わせを送信できる' do
      visit root_path
      click_link 'お問い合わせ'
      fill_in 'inquiry[email]', with: 'test@testexample.com'
      fill_in 'inquiry[text]', with: 'test-product-food'
      click_button '送信'
      expect(page).to have_content 'お問い合わせ完了'
      expect(page).to have_content 'お問い合わせありがとうございました'
      expect(page).to have_content 'トップページに戻る'
      click_link 'トップページに戻る'
      expect(current_path).to eq root_path
    end
  end

  context 'お問い合わせが送信できない' do
    it 'emailが正しくフォームに入力されていないため登録できない' do
      visit root_path
      click_link 'お問い合わせ'
      fill_in 'inquiry[email]', with: ''
      fill_in 'inquiry[text]', with: 'test-product-food'
      click_button '送信'
      expect(current_path).to eq inquiries_path
    end

    it 'textが正しくフォームに入力されていないので送信できない(1文字以上)' do
      visit root_path
      click_link 'お問い合わせ'
      fill_in 'inquiry[email]', with: 'test@testexample.com'
      fill_in 'inquiry[text]', with: ''
      click_button '送信'
      expect(current_path).to eq inquiries_path
    end
  end
end
