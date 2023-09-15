class SendingMailer < ApplicationMailer
  def send_when_admin_reply(user, contact) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @answer = contact.reply_text #返信内容
    mail to: user.email, subject: '【サイト名】 お問い合わせありがとうございます'
  end

  def reset_password_email(user)
    @greeting = "こんにちは"
    @user = User.find(user.id)
    @url = edit_password_reset_url(@user.reset_password_token)
    email(to: user.email, subject 'パスワード変更のお知らせ')
  end

  def welcome_email
    @user = params[:user]
    mail(
        to: emial_adress_with_name(@user.email),
        subject: 'ようこそ'
    )
  end
    
end
