class Webpage < ApplicationRecord
  has_many :bookmarks
  has_many :scrapes

  update_index('webpages#webpage') { self }

  def uri
    @uri ||= Addressable::URI.parse(raw_uri)
  end

  def uri= val
    self.raw_uri = val
  end

  def latest_scrape
    @latest_scrape ||= scrapes.order(created_at: :desc).first
  end
end
