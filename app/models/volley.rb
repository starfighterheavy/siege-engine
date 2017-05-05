class Volley < ActiveRecord::Base
  belongs_to :siege
  has_many :results, dependent: :destroy
  has_many :reports, dependent: :destroy

  after_update :status_change_listener, if: :status_changed?

  def to_h
    {
      id: id,
      name: name,
      status: status,
      results_count: results.count,
      reports: reports.map(&:to_h)
    }
  end

  private def status_change_listener
    if status == 'started'
      return unless status_was.nil?
      start!
    elsif status == 'paused'
      return unless status_was == 'started'
      pause!
    elsif status == 'canceled'
      return unless status_was == 'started' || status_was == 'paused'
      cancel!
    else
      raise 'unknown status change: ' + status
    end
  end

  private def start!
    Rails.logger.info "Starting Volley ##{id}"
  end

  private def pause!
    Rails.logger.info "Pausing Volley ##{id}"
  end

  private def cancel!
    Rails.logger.info "Canceling Volley ##{id}"
  end
end
