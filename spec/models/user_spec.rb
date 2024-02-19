require 'rails_helper'

RSpec.describe User, type: :model do

  it 'ユーザー名、email, password, password_confirmationがある場合有効' do
    user = User.new(
      name: 'testuserS',
      email: 'testtesttest@example.com',
      password: 'password',
      password_confirmation: 'password',
    )
    expect(user).to be_valid #ユーザーが有効である
  end

  it 'ユーザー名が空のため、無効' do
    user = FactoryBot.build(:user, name: nil)
    user.valid? # ユーザーの検証を実行
    expect(user.errors[:name]).to include("を入力してください")
  end

  it 'ユーザー名が最大25文字以上の場合は無効' do
    user = FactoryBot.build(:user, name: 'ABCDEFGHIJKLMNOPQRSTUVWXYZさん')
    user.valid?
    expect(user.errors[:name]).to include("は25文字以内で入力してください")
  end

  it 'ユーザー名は既に使用されているものは使用できないため無効' do
    exsiting_user = FactoryBot.create(:user, name: 'testuserS',
      email: 'testtesttest@example.com',
      password: 'password',
      password_confirmation: 'password',)
    new_user = FactoryBot.build(:user, name: 'testuserS')
    new_user.valid?
    expect(new_user.errors[:name]).to include("はすでに存在します")
  end

  it 'メールアドレスが存在しないため、無効' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it 'メールアドレスが既に存在するため無効' do
    exsiting_user = FactoryBot.create(:user, name: 'testuserS',
      email: 'testtesttest@example.com',
      password: 'password',
      password_confirmation: 'password',
    )
    new_user = FactoryBot.build(:user, email: 'testtesttest@example.com')
    new_user.valid?
    expect(new_user.errors[:email]).to include("はすでに存在します")
  end

  it 'パスワードが存在しないため、無効' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it 'パスワードが確認用と一致しないため、無効' do
    user = FactoryBot.build(:user, password: 'mismatch', password_confirmation: 'mismatch2')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

  it 'パスワードの長さは3文字以上出ない場合、無効' do
    user = build(:user, password: "a" * 2, password_confirmation: "a" * 2)
    user.valid?
    expect(user.errors[:password]).to include("は3文字以上で入力してください")
  end
end
