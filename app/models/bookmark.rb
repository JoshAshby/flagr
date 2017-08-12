class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :webpage

  validates_presence_of :user_id, :webpage_id
  validates_uniqueness_of :webpage_id, scope: :user_id

  update_index('webpages#bookmark') { self }
end
