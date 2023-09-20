class InquiryMailer < ApplicationMailer

  def inquiry_mail(inquiry)
    @inquiry = inquiry
    @greeting = 'お問い合わせありがとうございます'
    mail(to: 'notifications@expired-foods.com', subject: 'お問い合わせ')
  end
end