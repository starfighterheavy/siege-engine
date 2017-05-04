class Attacker < ActiveRecord::Base
  belongs_to :siege

  attr_encrypted :password

  validates_presence_of :username, :password, :login_url
end
