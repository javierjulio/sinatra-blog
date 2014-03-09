require './app'

Blog::App.set :url, 'http://blog.myblog.io/'
Blog::App.set :feed_title, 'My Blog Feed'
Blog::App.set :feed_url, '/feed'

run Blog::App

if Blog::App.settings.development?
  system "open http://localhost:#{ENV['PORT'] || 3000}"
end
