require 'securerandom'

class AccessKey < ActiveRecord::Base
  attr_encrypted :secret_access_key, key: '1af6cae6474c75352a517f41032528d9efb6f70538090e3c4012a9bcba0784c8'

  before_create do
    self.access_key_id = SecureRandom.uuid
    self.secret_access_key = SecureRandom.uuid
  end

  def self.authenticate(access_key_id, secret_access_key)
    key = AccessKey.find_by(access_key_id: access_key_id)
    return key if key.secret_access_key == secret_access_key
  end
end
