class Siege < ActiveRecord::Base
  belongs_to :access_key
  has_many :attackers
  has_many :targets
  has_many :results

  before_validation do
    self.max_strikes ||= 10000
    self.max_sieges ||= 10
  end
end
