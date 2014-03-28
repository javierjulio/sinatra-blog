module Blog
  module Helpers
    def title
      value = yield_content(:title)
      value.blank? ? 'Blog' : value
    end

    def url
      request.url
    end

    def description
      value = yield_content(:description)
      value.blank? ? '' : (value + '...')
    end

    def paginate_next_url
      number = params[:page].to_i
      "/page/#{number + 1}"
    end

    def paginate_previous_url
      number = params[:page].to_i
      return if number == 0
      "/page/#{number - 1}"
    end

    def paginate_previous?
      params[:page].to_i > 1
    end

    def paginate_next?(items, limit = 10)
      Array(items).length >= limit
    end

    ::Date::DATE_FORMATS[:short_ordinal] = lambda { |date|
      day_format = ActiveSupport::Inflector.ordinalize(date.day)
      date.strftime("%b #{day_format}, %Y") # => "Dec 25th, 2007"
    }
  end
end
