Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line, Rails.application.credentials.dig(:line, :login_channel_id), Rails.application.credentials.dig(:line, :login_secret)
end
