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

  test 'invalid /:slug returns not found status' do
    get '/non-existing-post'
    assert last_response.not_found?
  end

  test '/page/:page' do
    get '/page/1'
    assert last_response.ok?
  end

  test 'invalid /page/:page returns not found status' do
    get '/page/test'
    assert last_response.not_found?
  end

end
