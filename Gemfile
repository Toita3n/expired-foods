source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 5.0'
gem 'puma-daemon', require: false
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'mini_magick'
# gem 'google-cloud-vision'
gem 'dotenv-rails'
gem 'omniauth-line'
gem 'omniauth-rails_csrf_protection'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'font-awesome-sass', "~> 6.2", "< 6.3"
gem 'sassc', '2.1.0'
gem 'bootstrap5-kaminari-views', '~> 0.0.1'
gem 'kaminari'
gem 'config'
gem 'enum_help'
gem 'httparty'
gem 'line-bot-api'
gem 'sorcery'
gem 'faker'
gem 'rails-i18n'
gem 'typhoeus'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '6.2'
  gem 'letter_opener_web'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'simplecov', require: false
  gem 'spring'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'capistrano', require: false
  gem 'capistrano-bundler'
  gem 'capistrano3-puma'
  gem 'capistrano-rbenv'
  gem 'capistrano-rails', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'jquery-rails'
gem 'meta-tags'
gem 'sitemap_generator'

group :production do
  gem 'aws-sdk-s3', require: false
  # gem 'aws-sdk-rails', '~>3.6', '>= 3.6.1'
end
