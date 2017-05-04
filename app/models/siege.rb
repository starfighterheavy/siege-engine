class Siege < ActiveRecord::Base
  belongs_to :access_key
  has_many :attackers
  has_many :targets
  has_many :results
  has_many :reports

  before_validation do
    self.max_strikes ||= 10_000
    self.max_sieges ||= 10
  end
end
