require 'pathname'

module Blog
  module Models
    class Post
      def self.path
        Pathname(App.settings.root) + 'posts'
      end

      def self.all
        paths = Dir[(path + '**' + '*.md').to_s]
        posts = paths.map {|p| self.new(p) }
        posts.reject! {|p| p.draft? }
        posts.sort_by {|p| p.date || Date.current }.reverse
      end

      def self.paginate(page: 1, limit: 10)
        all[((page - 1) * limit)...(page * limit)] || []
      end

      def self.[](slug)
        slug  = slug.underscore.gsub(/\W/, '')
        paths = Dir[(path + '**' + "#{slug}.md").to_s]
        paths.first && self.new(paths.first)
      end

      def self.find(slug)
        self[slug]
      end

      def self.find!(slug)
        self[slug] || raise(NotFound.new)
      end

      def self.cache
        if App.settings.production?
          @cache ||= Dalli::Client.new
        else
          @cache ||= ActiveSupport::Cache::MemoryStore.new
        end
      end

      attr_reader :path

      def initialize(path)
        @path = Pathname(path)
        setup
      end

      def slug
        path.basename('.md').to_s.dasherize
      end

      def content
        @content ||= path.read
      end

      def markdown
        @markdown ||= begin
          eruby = Erubis::EscapedEruby.new(content)
          eruby.result(binding).strip
        end
      end

      alias_method :setup, :markdown

      def html
        @html ||= begin
          renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
          renderer.render(markdown).strip
        end
      end

      def title(value = nil)
        @title = value if value
        @title
      end

      def date(value = nil)
        @date = Date.parse(value) if value
        @date
      end

      def description
        (markdown[0..60] || '').strip
      end

      def author(value = nil)
        @author = value if value
        @author
      end

      def draft!
        @draft = true
      end

      def draft?
        @draft
      end

      def cache_key
        [slug, path.mtime.to_i].join(':')
      end

      def render
        self.class.cache.fetch(cache_key) do
          html
        end
      end
    end
  end
end
