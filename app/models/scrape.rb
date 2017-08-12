class Scrape < ApplicationRecord
  belongs_to :webpage

  update_index('webpages#webpage') { webpage }
end
