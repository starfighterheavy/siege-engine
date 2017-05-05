require_dependency 'start_volley_worker'

class Volley < ActiveRecord::Base
  belongs_to :siege
  has_many :results, dependent: :destroy
  has_many :reports, dependent: :destroy

  after_update :status_change_listener, if: :saved_change_to_status?

  def to_h
    {
      id: id,
      name: name,
      status: status,
      strikes: strikes,
      results_count: results.count
    }
  end

  def restart!
    results.destroy_all
    update_attribute(:status, nil)
    update_attribute(:status, 'started')
  end

  def strike_queue
    sum_priority = siege.targets.sum(:priority)
    queue = []
    siege
      .targets
      .find_each { |t| queue << Array.new(target_strike_count(t.priority, sum_priority), t.id) }
    queue.flatten.shuffle
  end

  def target_strike_count(priority, sum_priority)
    (strikes.to_f * (priority.to_f / sum_priority.to_f)).to_i
  end

  private def status_change_listener
    old_value = saved_change_to_status[0]
    if status == 'started'
      return unless old_value.nil?
      start!
    elsif status == 'paused'
      return if [nil, 'paused', 'canceled'].include? old_value
      pause!
    elsif status == 'canceled'
      return if ['canceled'].include? old_value
      cancel!
    end
  end

  private def start!
    Rails.logger.info "Starting Volley ##{id}"
    StartVolleyWorker.perform_async(id)
  end

  private def pause!
    Rails.logger.info "Pausing Volley ##{id}"
  end

  private def cancel!
    Rails.logger.info "Canceling Volley ##{id}"
  end
end
