require 'test_helper'

class RoutesTest < MiniTest::Unit::TestCase

  test 'index' do
    get '/'
    assert last_response.ok?
  end

  test 'feed' do
    get '/feed'
    assert last_response.ok?
  end

  test 'pagination' do
    get '/page/1'
    assert last_response.ok?
  end

end
