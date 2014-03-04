require 'test_helper'

class RoutesTest < MiniTest::Unit::TestCase

  def test_index
    get '/'
    assert last_response.ok?
  end

  def test_feed
    get '/feed'
    assert last_response.ok?
  end

  def test_pagination
    get '/page/1'
    assert last_response.ok?
  end

end
