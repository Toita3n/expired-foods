class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@expired-foods.com'
  layout 'mailer'
end
