require 'test_helper'

class TestHelper
  include Blog::Helpers
  include Sinatra::ContentFor
  attr_accessor :request, :params
end

class HelpersTest < MiniTest::Unit::TestCase

  def setup
    @helper = TestHelper.new
  end

  test 'default title' do
    assert_equal @helper.title, 'Blog'
  end

  test 'yielded title' do
    title = 'A Test Post'
    @helper.content_for(:title) { title }

    assert_equal @helper.title, title
  end

  test 'default description' do
    assert_equal @helper.description, ''
  end

  test 'yielded description' do
    description = 'This is a custom description'
    @helper.content_for(:description) { description }

    assert_equal @helper.description, "#{description}..."
  end

  test 'request url' do
    request = MiniTest::Mock.new
    request.expect :url, 'test.com'
    @helper.request = request

    assert_equal @helper.url, 'test.com'
  end

end

class PaginationHelpersTest < MiniTest::Unit::TestCase

  def setup
    @helper = TestHelper.new
  end

  test 'paginate_next_url default is page 1' do
    @helper.stub :params, {} do
      assert_equal @helper.paginate_next_url, '/page/1'
    end
  end

  test 'paginate_next_url with param increments page number by 1' do
    @helper.stub :params, {page: 2} do
      assert_equal @helper.paginate_next_url, '/page/3'
    end
  end

  test 'paginate_previous_url with no param returns -1' do
    @helper.stub :params, {} do
      assert_equal @helper.paginate_previous_url, '/page/-1'
    end
  end

  test 'paginate_previous_url with param decrements page number by 1' do
    @helper.stub :params, {page: 3} do
      assert_equal @helper.paginate_previous_url, '/page/2'
    end
  end

  test 'paginate_next? returns true with items exceeding limit' do
    items = Array(1..20)

    assert @helper.paginate_next?(items)
  end

  test 'paginate_next? returns false with fewer items than limit' do
    items = Array(1..5)

    assert !@helper.paginate_next?(items)
    assert !@helper.paginate_next?(nil)
  end

  test 'paginate_previous? returns true' do
    @helper.stub :params, {page: 2} do
      assert @helper.paginate_previous?
    end
  end

  test 'paginate_previous? returns false' do
    @helper.stub :params, {page: 1} do
      assert !@helper.paginate_previous?
    end

    @helper.stub :params, {} do
      assert !@helper.paginate_previous?
    end
  end

end
