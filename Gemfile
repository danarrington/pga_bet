source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.1.1'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'devise'
gem 'foundation-rails'
gem 'slim-rails'
gem 'golfscrape', git: 'git://github.com/danarrington/golfscrape.git'
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'awesome_print'
  gem 'mr_video'
end
group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'faker'
  gem 'vcr'
  gem 'webmock'
  gem 'vcr_cable'
end
group :test do
  gem 'capybara'
  gem 'timecop'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'webmock'
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
