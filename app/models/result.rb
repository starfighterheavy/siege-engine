class Result < ActiveRecord::Base
  belongs_to :volley
  belongs_to :target

  default_scope { includes(:target) }

  after_commit do
    volley.with_lock do
      volley.done! if volley.results.count == volley.strikes
    end
  end

  def to_h
    {
      id: id,
      volley_id: volley_id,
      target: target.to_h,
      code: code,
      time: time,
      created_at: created_at
    }
  end
end
