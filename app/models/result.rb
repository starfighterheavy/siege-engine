class Result < ActiveRecord::Base
  belongs_to :volley
  belongs_to :target

  default_scope { includes(:target) }

  before_create do
    self.uid ||= SecureRandom.uuid
  end

  after_commit do
    volley.with_lock do
      volley.done! if volley.results.count == volley.strikes
    end
  end

  def to_h
    {
      uid: uid,
      volley_uid: volley.uid,
      target: target.to_h,
      code: code,
      body: body,
      time: time,
      created_at: created_at
    }
  end
end
