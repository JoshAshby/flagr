class Scrape < ApplicationRecord
  belongs_to :webpage

  update_index('scrapes') { self }
end
