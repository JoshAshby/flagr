class ExtractionService
  attr_reader :uri, :body

  def initialize uri:, body:
    @uri = uri
    @body = body
  end

  def extract!
    {
      language: language,
      links: links,
      body: content
    }
  end

  private

  def nokogiri
    @nokogiri_document ||= Nokogiri::HTML.parse body
  end

  def loofah
    @loofah_document ||= Loofah.document body
  end

  def content_loofah
    @loofah ||= Loofah.fragment(Readability::Document.new(body).content)
  end

  def content
    @content ||= content_loofah.scrub!(:strip).text
  end

  def links
    @links ||= extract_links
  end

  def is_english?
    @is_english ||= (extract_language =~ /^en/) != nil
  end

  def language
    @language ||= extract_language
  end

  def extract_links
    nokogiri.xpath("//a/@href").map do |href|
      begin
        (uri + href).to_s.split("#", 2).first
      rescue URI::InvalidURIError, NoMethodError
        next
      end
    end.uniq.compact
  end

  def extract_language
    lang_attr = nokogiri.xpath("/html/@lang").first

    # Assume that it is english if no language is set
    return "en" unless lang_attr

    lang_attr.value
  end
end
