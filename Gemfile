source 'https://rubygems.org'

ruby '2.1.1'

gem 'sinatra', require: 'sinatra/base'
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
gem 'stylus'
gem 'stylus-source', '~> 0.40.0'
# gem 'eco'
# gem 'json', '~> 1.8.1'
gem 'sinatra-contrib'

group :development do
  gem 'thin'
  gem 'rack-mini-profiler'
end

group :production do
  gem 'rails_12factor' # https://devcenter.heroku.com/articles/rails4#logging-and-assets
  gem 'memcachier'
  gem 'dalli'
  gem 'newrelic_rpm'
end
