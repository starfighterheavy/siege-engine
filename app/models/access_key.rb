require 'secure_random'

class AccessKey < ActiveRecord::Base
  attr_encrypted :secret_access_key

  before_create do
    self.access_key_id = SecureRandom.uuid
    self.secret_access_key = SecureRandom.uuid
  end
end
