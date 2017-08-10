class Authorization < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def self.find_or_create_from_auth_hash auth_hash, user: nil
    auth = find_by provider: auth_hash['provider'], uid: auth_hash['uid']
    return auth if auth

    user ||= User.create_from_auth_hash! auth_hash
    Authorization.create user: user, uid: auth_hash['uid'], provider: auth_hash['provider']
  end
end
