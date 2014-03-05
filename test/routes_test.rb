require 'test_helper'

class RoutesTest < MiniTest::Unit::TestCase

  test 'index page' do
    get '/'
    assert last_response.ok?
  end

  test '/feed' do
    get '/feed'
    assert last_response.ok?
  end

  test '/:slug' do
    get '/my-first-post'
    assert last_response.ok?
  end

  test '/page/:number' do
    get '/page/1'
    assert last_response.ok?
  end

end
