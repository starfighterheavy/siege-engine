require 'csv'
require 'report'

class ReportWorker < BaseWorker
  def run
    report.update_attribute(:status, 'started')
    report.content = %w[id target_id target_url target_method code body time created_at].to_csv
    volley.results.find_each do |result|
      target = result.target
      report.content += [result.id, target.id, target.url, target.method, result.code, result.body, result.time, result.created_at].to_csv
    end
    report.status = 'done'
    report.save!
  end

  def report
    @report ||= Report.find(opts['report_id'])
  end

  def volley
    @volley ||= report.volley
  end
end
