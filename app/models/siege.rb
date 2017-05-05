class Siege < ActiveRecord::Base
  belongs_to :access_key
  has_many :attackers
  has_many :targets
  has_many :results
  has_many :reports

  def to_h
    {
      id: id,
      strikes: strikes
    }
  end
end
