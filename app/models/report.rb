require_dependency 'report_worker'

class Report < ActiveRecord::Base
  belongs_to :siege

  after_commit on: [:create] do
    ReportWorker.perform_async(id)
  end

  def to_h
    {
      id: id,
      name: name,
      status: status
    }
  end
end
