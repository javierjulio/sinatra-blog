require 'sprockets'
require 'sprockets-sass'
require 'sprockets-helpers'
require 'sass'

module Blog
  module Extensions
    module Assets extend self
      class UnknownAsset < StandardError; end

      module Helpers
        def asset_path(name)
          asset = settings.assets[name]
          raise UnknownAsset, "Unknown asset: #{name}" unless asset
          "#{settings.asset_host}/assets/#{asset.digest_path}"
        end
      end

      def registered(app)
        app.set :assets, assets = Sprockets::Environment.new(app.settings.root)

        assets.append_path('app/assets/javascripts')
        assets.append_path('app/assets/stylesheets')
        assets.append_path('app/assets/images')
        assets.append_path('vendor/assets/javascripts')
        assets.append_path('vendor/assets/stylesheets')

        Sprockets::Helpers.configure do |config|
          config.environment = assets
          config.prefix      = 'app/assets'
          config.digest      = false
        end

        app.set :asset_host, ''

        app.configure :development do
          assets.cache = Sprockets::Cache::FileStore.new('./tmp')
        end

        app.configure :production do
          assets.cache          = Sprockets::Cache::MemcacheStore.new
          assets.js_compressor  = Closure::Compiler.new
          assets.css_compressor = YUI::CssCompressor.new
        end

        app.helpers Helpers
      end
    end
  end
end
