module Blog
  module Routes
    class Posts < Base
      error Models::NotFound do
        error 404
      end

      get '/feed', provides: 'application/atom+xml' do
        @posts = Post.paginate(limit: Blog::App.settings.items_in_feed)
        builder :feed
      end

      get %r{/page/([\d]+)} do |page|
        params[:page] = page
        @posts = Post.paginate(page: page.to_i, limit: App.settings.items_in_index)
        erb :index
      end

      get '/:slug' do
        @post = Post.find!(params[:slug])
        erb :post
      end

      get '/' do
        @posts = Post.paginate(limit: App.settings.items_in_index)
        erb :index
      end
    end
  end
end
