xml.instruct! :xml, :version => '1.0'
xml.feed('xml:lang' => 'en-US', 'xmlns' => 'http://www.w3.org/2005/Atom') do
  xml.id Blog::App.url
  xml.title Blog::App.feed_title
  xml.link(rel: 'alternate', type: 'text/html', href: Blog::App.url)
  xml.link(rel: 'self', type: 'application/atom+xml', href: Blog::App.feed_url)
  xml.updated @posts.first && @posts.first.date.xmlschema

  @posts.each do |post|
    xml.entry do
      xml.id "#{Blog::App.url}#{post.slug}"
      xml.title post.title
      xml.link rel: 'alternate', type: 'text/html', href: "#{Blog::App.url}#{post.slug}"
      xml.published post.date.xmlschema
      xml.updated post.date.xmlschema
      xml.author do
        xml.name post.author
      end
      xml.content post.render, type: 'html'
    end
  end
end
