require 'test_helper'

class FindersTest < MiniTest::Unit::TestCase

  test 'Post.path is posts directory path' do
    assert_equal Pathname(app.settings.root) + 'posts', Post.path
  end

  test 'Post.all loads only published posts' do
    posts = Blog::Models::Post.all

    assert_equal posts.size, 2
    posts.each do |post|
      assert !post.draft?
    end
  end

  test 'Post.all loads published posts ordered by most recent' do
    posts = Blog::Models::Post.all
    post_dates = posts.map { |p| p.date }

    assert_equal post_dates, [Date.parse('3rd March 2014'), Date.parse('3rd February 2013')]
  end

  test 'Post.find loads published post by key' do 
    post = Blog::Models::Post.find('my_first_post')

    assert_equal post.title, 'My First Post!'
  end

  test 'Post.find loads draft post by key' do
    post = Blog::Models::Post.find('a_draft_post')

    assert post.draft?
  end

  test 'Post.find! raises an error if post not found' do
    assert_raises(Blog::Models::NotFound) { Blog::Models::Post.find!('non_existing_post') }
  end

end

class AccessorsTest < MiniTest::Unit::TestCase

  def setup
    @post_file = fixture_path('posts/my_first_post.md')
    @post = Blog::Models::Post.new(@post_file)
  end

  test 'slug is dasherized post title' do
    assert_equal @post.slug, 'my-first-post'
  end

  test 'title' do
    assert_equal @post.title, 'My First Post!'
  end

  test 'author' do
    assert_equal @post.author, 'Javier Julio'
  end

  test 'date' do
    assert_equal @post.date, Date.parse('3rd March 2014')
  end

  test 'post is not a draft' do
    assert !@post.draft?
  end

  test 'draft! sets draft flag to true' do
    assert !@post.draft?
    @post.draft!
    assert @post.draft?
  end

  test 'content matches file contents' do
    assert_equal @post.content, File.read(@post_file)
  end

  test 'markdown' do
    assert_equal @post.markdown, 'This is a **published** post.'
  end

  test 'html' do
    assert_equal @post.html, '<p>This is a <strong>published</strong> post.</p>'
  end

  test 'cache_key uses slug and file modified time' do
    current_time = Time.now

    @post.path.stub :mtime, current_time do
      assert_equal @post.cache_key, "#{@post.slug}:#{current_time.to_i}"
    end
  end

  test 'render returns cached html' do
    html = '<p>This is a <strong>published</strong> post.</p>'
    assert_equal @post.render, html
    @post.instance_variable_set(:@html, '<p>Test.</p>')
    assert_equal @post.render, html
  end

end

class EmptyPostContentTest < MiniTest::Unit::TestCase

  def setup
    @post_file = fixture_path('posts/an_empty_post.md')
    @post = Blog::Models::Post.new(@post_file)
  end

  test 'content matches file contents' do
    assert_equal @post.content, File.read(@post_file)
  end

  test 'markdown is an empty string' do
    assert_equal @post.markdown, ''
  end

  test 'html is an empty string' do
    assert_equal @post.html, ''
  end

end
