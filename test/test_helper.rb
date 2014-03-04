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

  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
    defined = instance_method(test_name) rescue false
    raise "#{test_name} is already defined in #{self}" if defined
    if block_given?
      define_method(test_name, &block)
    else
      define_method(test_name) do
        flunk "No implementation provided for #{name}"
      end
    end
  end

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
