source 'https://rubygems.org'
ruby '2.2.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'therubyracer'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0'
end

# Use sqlite3 as the database for Active Record
group :development do
   gem 'sqlite3'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :development do
    gem 'capistrano',         require: false
    gem 'capistrano-rvm',     require: false
    gem 'capistrano-rails',   require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano3-puma',   require: false
end

gem 'devise', '~> 3.5'

gem 'figaro'

gem 'bootstrap-sass', '~> 3.3'

gem 'font-awesome-sass'

gem 'oauth'

gem 'omniauth'

gem 'omniauth-google-oauth2'

gem 'httparty'

gem 'whenever', require: false

gem 'gon'
gem 'rabl-rails'

gem 'rubocop'
gem 'business_time'

gem 'resque', :require => "resque/server"
gem 'redis', '~>3.2'
gem 'resque-scheduler'
gem 'resque-logger'


gem 'puma'