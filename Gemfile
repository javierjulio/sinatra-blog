source 'https://rubygems.org'

ruby '2.1.3'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'
gem 'unicorn'
gem 'erubis'
gem 'i18n'
gem 'activesupport', '~> 4.1'
gem 'rake'
gem 'rack-ssl'
gem 'rack-standards'
gem 'redcarpet'
gem 'builder'
gem 'sprockets'
gem 'uglifier'
gem 'closure-compiler'
gem 'yui-compressor'
gem 'coffee-script'
gem 'sass'
gem 'sprockets-sass'
gem 'sprockets-helpers'
gem 'sprockets-memcache-store'
gem 'coveralls', require: false

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
