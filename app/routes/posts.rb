module Blog
  module Routes
    class Posts < Base
      error Models::NotFound do
        error 404
      end

      get '/feed', provides: 'application/atom+xml' do
        @posts = Post.all
        builder :feed
      end

      get %r{/page/([\d]+)} do
        @posts = Post.paginate(params[:number].to_i)
        erb :index
      end

      get '/:slug' do
        @post = Post.find!(params[:slug])
        erb :post
      end

      get '/' do
        @posts = Post.paginate
        erb :index
      end
    end
  end
end