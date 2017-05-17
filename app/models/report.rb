require_dependency 'report_worker'

class Report < ActiveRecord::Base
  belongs_to :volley

  after_commit on: [:create] do
    ReportWorker.call(report_id: id)
  end

  def to_h
    {
      id: id,
      name: name,
      status: status
    }
  end
end
