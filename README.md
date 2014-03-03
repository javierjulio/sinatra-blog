## Sinatra Example Blog

This is a good example of structuring a Sinatra app.
Feel free to clone it, browse the source, customize it
and use it as your own blog.

Good examples of the following:

* Using Sinatra routes as middleware
* GZip and caching
* RSS feed of posts
* Sprockets and asset management
* Markdown and Erb
* Unicorn and Heroku
* Sass and CoffeeScript

## Installation

    git clone https://github.com/javierjulio/sinatra-blog.git
    cd sinatra-blog
    bundle install
    foreman start

### Deploy to Heroku

    heroku create myblog
    heroku labs:enable user-env-compile
    heroku addons:add memcachier:dev
    heroku addons:add newrelic:stark

    bundle exec rake deploy:production
