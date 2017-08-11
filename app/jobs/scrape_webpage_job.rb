class ScrapeWebpageJob < ApplicationJob
  queue_as :default

  attr_reader :uri, :res

  def perform(uri)
    @uri = Addressable::URI.parse(uri)

    return unless allowed?

    res = scrape
    webpage = Webpage.find_or_create_by(raw_uri: uri)

    extracted = ExtractionService.new(uri: uri, body: res.body).extract!

    webpage.scrapes.create(**extracted)
  end

  def connection
    @connection ||= Fetcher.new
  end

  def allowed?
    res = connection.get uri + "/robots.txt"
    body = res.body || ""

    return true if res.status == 404

    parser = Robotstxt.parse body, connection.user_agent

    parser.allowed? uri.to_s
  rescue Faraday::TimeoutError, URI::InvalidURIError => e
    Rails.logger.error "Problem checking the robot.txt for #{ uri.to_s } #{ e }"
  end

  def scrape
    connection.get uri
  rescue FaradayMiddleware::RedirectLimitReached, Faraday::TimeoutError, URI::InvalidURIError => e
    Rails.logger.error "Problem fetching body for #{ uri.to_s } #{ e }"
  end
end
