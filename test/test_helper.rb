ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'

require File.expand_path '../../app.rb', __FILE__

require 'bundler'
Bundler.require

class MiniTest::Unit::TestCase

  include Rack::Test::Methods

  FIXTURE_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "fixtures"))

  Blog::App.settings.root = FIXTURE_ROOT

  def app
    Blog::App
  end

  def fixture_path(path)
    if path.match(FIXTURE_ROOT)
      path
    else
      File.join(FIXTURE_ROOT, path)
    end
  end

end
