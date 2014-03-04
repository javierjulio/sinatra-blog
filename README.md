[![Build Status](https://travis-ci.org/javierjulio/sinatra-blog.png?branch=master)](https://travis-ci.org/javierjulio/sinatra-blog)

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
* Deploy task with auto tagging

## Installation

    git clone https://github.com/javierjulio/sinatra-blog.git
    cd sinatra-blog
    bundle install
    foreman start

### Tests

    bundle exec rake test

### Deploy to Heroku

    heroku create myblog
    heroku labs:enable user-env-compile
    heroku addons:add memcachier:dev
    heroku addons:add newrelic:stark

    bundle exec rake deploy:production
