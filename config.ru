require './app'

# TODO: the following works so start setting up config items
# Blog::App.set :new_config_item, 'test config'
# puts Blog::App.new_config_item

run Blog::App

if Blog::App.settings.development?
  system "open http://localhost:#{ENV['PORT'] || 3000}"
end
