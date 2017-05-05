class Siege < ActiveRecord::Base
  belongs_to :access_key
  has_many :attackers
  has_many :targets
  has_many :volleys

  def to_h
    {
      id: id,
      name: name,
      attackers_count: attackers.count,
      targets_count: targets.count,
      volleys: volleys.map(&:to_h)
    }
  end
end
