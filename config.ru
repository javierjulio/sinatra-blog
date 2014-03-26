require './app'

# TODO: new config items: site_title, site_description, items_in_index
# TODO: consider precompiling parsed md erb data into JSON for faster processing on server

Blog::App.set :url, 'http://blog.myblog.io/'
Blog::App.set :feed_title, 'My Blog Feed'
Blog::App.set :feed_url, '/feed'
Blog::App.set :items_in_feed, 25

run Blog::App

if Blog::App.settings.development?
  system "open http://localhost:#{ENV['PORT'] || 3000}"
end
