require_dependency 'report_worker'

class Report < ActiveRecord::Base
  belongs_to :volley

  before_create do
    self.uid ||= SecureRandom.uuid
  end

  after_commit on: [:create] do
    ReportWorker.call("report_id" => id)
  end

  def to_h
    {
      uid: uid,
      name: name,
      status: status
    }
  end
end
