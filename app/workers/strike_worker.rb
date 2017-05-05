class StrikeWorker < BaseWorker
  def perform(target_id, volley_id)
    target = Target.find(target_id)
    logger.info "Performing strike on ##{target_id} - #{target.url}"
    uri = URI.parse(target.url)
    start_time = Time.now
    response = Net::HTTP.get_response(uri)
    elapsed_time = (Time.now - start_time) * 1000
    Result.create!(target_id: target_id, code: response.code, time: elapsed_time, volley_id: volley_id)
    logger.info "Strike on ##{target_id} complete in #{elapsed_time} ms"
  end
end
