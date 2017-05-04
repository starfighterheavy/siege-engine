class Report < ActiveRecord::Base
  belongs_to :siege

  after_create do
    Workers::ReportWorker.perform_async(id)
  end
end
