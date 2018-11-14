class Attacker < ActiveRecord::Base
  belongs_to :siege
  has_many :targets, dependent: :destroy

  attr_encrypted :password, key: '711550dbd707fbedb531983f6558adba'

  before_create do
    self.uid ||= SecureRandom.uuid
  end

  def to_h
    {
      uid: uid,
      username: username,
      username_field: username_field,
      password_field: password_field,
      new_session_url: new_session_url,
      create_session_url: create_session_url
    }
  end
end
