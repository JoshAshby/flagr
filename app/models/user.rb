class User < ApplicationRecord
  has_many :authorizations

  def self.create_from_auth_hash! auth_hash
    username = auth_hash.dig 'info', 'name'

    username ||= "test"

    create username: username
  end
end
