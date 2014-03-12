require './app'

# TODO: add root config and use in app/routes
# TODO: add test and implementation for items_in_feed

Blog::App.set :url, 'http://blog.myblog.io/'
Blog::App.set :feed_title, 'My Blog Feed'
Blog::App.set :feed_url, '/feed'
Blog::App.set :items_in_feed, 25

run Blog::App

if Blog::App.settings.development?
  system "open http://localhost:#{ENV['PORT'] || 3000}"
end
