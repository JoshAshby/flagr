class User < ApplicationRecord
  has_many :authorizations

  def self.create_from_auth_hash! auth_hash
    username = auth_hash.dig 'user_info', 'name'

    fail "No username available" unless username

    create username: username
  end
end
