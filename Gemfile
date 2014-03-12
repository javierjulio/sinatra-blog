source 'https://rubygems.org'

ruby '2.1.1'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'
gem 'unicorn'
gem 'erubis'
gem 'i18n'
gem 'activesupport'
gem 'rake'
gem 'rack-ssl'
gem 'redcarpet'
gem 'builder'
gem 'sprockets'
gem 'uglifier'
gem 'closure-compiler'
gem 'yui-compressor'
gem 'coffee-script'
gem 'sass', '~> 3.2.15'
gem 'sprockets-sass'
gem 'sprockets-helpers'

group :test do
  gem 'minitest'
  gem 'rack-test'
end

group :production do
  gem 'rails_12factor' # https://devcenter.heroku.com/articles/rails4#logging-and-assets
  gem 'memcachier'
  gem 'dalli'
  gem 'newrelic_rpm'
end
