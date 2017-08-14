class Webpage < ApplicationRecord
  has_many :bookmarks
  has_many :scrapes

  update_index('webpages#webpage') { self }
  after_commit :enqueue_scrape, on: :create

  def parsed_uri
    @parsed_uri ||= Addressable::URI.parse(uri)
  end

  def parsed_uri= val
    self.raw_uri = val
  end

  def latest_scrape
    @latest_scrape ||= scrapes.order(created_at: :desc).first
  end

  def enqueue_scrape
    ScrapeWebpageJob.perform_later(webpage: self)
  end
end
