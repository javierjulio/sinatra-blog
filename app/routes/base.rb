module Blog
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, App.settings.root
        set :views, App.settings.views

        disable :method_override
        disable :protection
        disable :static

        set :erb, escape_html: true,
                  layout_options: {views: 'app/views/layouts'}

        enable :use_code
      end

      register Extensions::Assets
      helpers Helpers
      helpers Sinatra::ContentFor
    end
  end
end
