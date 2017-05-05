class Attacker < ActiveRecord::Base
  belongs_to :siege
  has_many :targets

  attr_encrypted :password, key: '3849fdd808defd9bc8d70a56691377c961b44938d14bd7272064d7800fda04b5'

  validates_presence_of :username, :password, :login_url

  def to_h
    {
      id: id,
      username: username,
      login_url: login_url
    }
  end
end
