require 'securerandom'

class AccessKey < ActiveRecord::Base
  attr_encrypted :secret_access_key, key: 'ff6a3fdea1d25fb2ab3847000a16bea1'
  attribute :secret_access_key

  has_many :sieges
  has_many :attackers, through: :sieges
  has_many :targets, through: :attackers
  has_many :volleys, through: :sieges

  before_create do
    self.access_key_id ||= SecureRandom.uuid
    self.secret_access_key ||= SecureRandom.uuid
    self.max_strikes ||= 10_000
    self.max_sieges ||= 10
  end

  def self.authenticate(access_key_id, secret_access_key)
    key = AccessKey.find_by!(access_key_id: access_key_id)
    return key if key.secret_access_key == secret_access_key
  end
end
