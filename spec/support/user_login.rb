module UserLogin
  def login_as(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'testpassword'
    find(".btn-login").click
  end
end
