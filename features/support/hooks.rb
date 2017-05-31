Before do
  @se_host = ENV.fetch('SE_HOST'){ 'http://0.0.0.0:3000' }
  @target_host = ENV.fetch('TARGET_HOST'){ 'http://0.0.0.0:4000' }
end

AfterStep do
  @previous_step_time = @current_step_time
  @current_step_time = Time.now
  if previous_step_time && previous_step_time > (ENV.fetch('TIMEOUT'){ '7000' }).to_i
    raise "Step took too long: #{previous_step_time} ms"
  end
end
