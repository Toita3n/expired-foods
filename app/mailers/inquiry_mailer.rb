class InquiryMailer < ApplicationMailer

  def inquiry_mail(inquiry)
    @inquiry = inquiry
    @greeting = 'お問い合わせありがとうございます'
    mail(to: @inquiry.email, subject: 'お問い合わせ')
  end
end
