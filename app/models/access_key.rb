require 'secure_random'

class AccessKey < ActiveRecord::Base
  attr_encrypted :secret_access_key

  before_create do
    self.access_key_id = SecureRandom.uuid
    self.secret_access_key = SecureRandom.uuid
  end

  def self.authenticate(access_key_id, secret_access_key)
    key = AccessKey.find_by(access_key_id: access_key_id)
    return key if key.secret_access_key == secret_access_key
  end
end
