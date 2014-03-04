require 'test_helper'

class FindersTest < MiniTest::Unit::TestCase

  def test_path_is_posts_directory_path
    assert_equal Pathname(app.settings.root) + 'posts', Post.path
  end

  def test_all_loads_all_published_posts
    posts = Blog::Models::Post.all

    assert_equal posts.size, 2
    assert_equal posts.first.title, 'My First Post!'
    assert_equal posts.second.title, 'An Empty Post'

    posts.each do |post|
      assert !post.draft?
    end
  end

  def test_find_finds_published_posts
    post = Blog::Models::Post.find('my_first_post')

    assert_equal post.title, 'My First Post!'
  end

  def test_find_finds_draft_post_too
    post = Blog::Models::Post.find('a_draft_post')

    assert post.draft?
  end

  def test_find_bang_raises_error
    assert_raises(Blog::Models::NotFound) { Blog::Models::Post.find!('non_existing_post') }
  end

end

class AccessorsTest < MiniTest::Unit::TestCase

  def setup
    @post = Blog::Models::Post.new(fixture_path('posts/my_first_post.md'))
  end

  def test_slug
    assert_equal @post.slug, 'my-first-post'
  end

  def test_title
    assert_equal @post.title, 'My First Post!'
  end

  def test_author
    assert_equal @post.author, 'Javier Julio'
  end

  def test_date
    assert_equal @post.date, Date.parse('3rd March 2014')
  end

  def test_post_is_not_a_draft
    assert !@post.draft?
  end

  def test_draft_bang_sets_draft_flag
    assert !@post.draft?
    @post.draft!
    assert @post.draft?
  end

  def test_markdown
    assert_equal @post.markdown, 'This is a **published** post.'
  end

  def test_html
    assert_equal @post.html, '<p>This is a <strong>published</strong> post.</p>'
  end

  def test_cache_key
    current_time = Time.now

    @post.stub :mtime, current_time do
      assert_equal @post.cache_key, "#{@post.slug}:#{current_time.to_i}"
    end
  end

end

class EmptyPostContentTest < MiniTest::Unit::TestCase

  def setup
    @post_file = fixture_path('posts/an_empty_post.md')
    @post = Blog::Models::Post.new(@post_file)
  end

  def test_content
    assert_equal @post.content, File.read(@post_file)
  end

  def test_markdown
    assert_equal @post.markdown, ''
  end

  def test_html
    assert_equal @post.html, ''
  end

end
