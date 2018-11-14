class Target < ActiveRecord::Base
  belongs_to :attacker

  before_create do
    self.uid ||= SecureRandom.uuid
  end

  def siege
    attacker.siege
  end

  def to_h
    {
      uid: uid,
      attacker_id: attacker.id,
      priority: priority,
      method: method,
      url: url,
      body: body,
      content_type: content_type,
      authenticated: authenticated
    }
  end
end
