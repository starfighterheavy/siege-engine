require 'csv'

module Workers
  class ReportWorker
    def perform(report_id)
      @report = Report.find(report_id)
      @siege = @report.siege
      @report.update_attribute(:status, 'started')
      @report.content = %w[id target_id target_url target_method code time created_at].to_csv
      @siege.results.find_each do |result|
        target = result.target
        @report.content += [result.id, target.id, target.url, target.method, result.code, result.time, result.created_at].to_csv
      end
      @report.status = 'done'
      @report.save!
    end
  end
end
