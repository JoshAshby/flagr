class Webpage < ApplicationRecord
  has_many :bookmarks
  has_many :scrapes

  def uri
    @uri ||= Addressable::URI.parse(raw_uri)
  end

  def uri= val
    self.raw_uri = val
  end
end
