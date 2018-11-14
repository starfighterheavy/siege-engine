class Siege < ActiveRecord::Base
  belongs_to :access_key
  has_many :attackers
  has_many :targets, through: :attackers
  has_many :volleys

  before_create do
    self.uid ||= SecureRandom.uuid
  end

  def to_h
    {
      uid: uid,
      name: name,
      store_body: store_body,
      attackers_count: attackers.count,
      targets_count: targets.count,
      volleys: volleys.map(&:to_h)
    }
  end
end
