class Target < ActiveRecord::Base
  belongs_to :attacker
  belongs_to :siege

  def to_h
    {
      id: id,
      priority: priority,
      method: method,
      url: url,
      body: body,
      content_type: content_type
    }
  end
end
