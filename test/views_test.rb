require 'test_helper'

class ViewsTest < MiniTest::Unit::TestCase

  test 'index lists recent posts' do
    get '/'

    assert_match /My First Post/i, last_response.body
    assert_match /href="\/my\-first\-post"/i, last_response.body
    assert_match /An Empty Post/i, last_response.body
    assert_match /href="\/an\-empty\-post"/i, last_response.body
  end

  test 'post' do
    post = Blog::Models::Post.new(fixture_path('posts/my_first_post.md'))

    get '/my-first-post'

    assert_match /#{post.title}/i, last_response.body
    assert_match /#{post.date.to_s}/i, last_response.body
    assert_match /#{post.date.to_s(:short_ordinal)}/i, last_response.body
    assert_match /#{post.author}/i, last_response.body
    assert_match /#{post.html}/i, last_response.body
  end

  test 'post shows draft notice if draft' do
    get '/a-draft-post'

    assert_match /This is an unpublished draft/i, last_response.body
  end

  test 'feed' do
    # TODO: when running test in Travis the date/time has different timezone
    xml_output = fixture('feed.xml')

    get '/feed'

    assert_equal last_response.body, xml_output
  end

end
