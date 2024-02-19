require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'password_resetのメールが送信できる' do
    let(:user) { FactoryBot.create(:user, password: "password", password_confirmation: "password") }
    let!(:user_token_create) { user&.deliver_reset_password_instructions! }
    let(:mail) { UserMailer.reset_password_email(user) }
    let(:mail_body) {  mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join }

    it 'メールのsubjectが正しく書いてある' do
      expect(mail.subject).to eq("expired-foodsのパスワード変更")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["expired.foodsapp@gmail.com"])
    end

    it 'メール本文が正しく書いてある' do
      expect(mail_body).to match edit_password_reset_url(user.reset_password_token)
      expect(mail_body).to match CGI.escape(user.email)
    end
  end
end