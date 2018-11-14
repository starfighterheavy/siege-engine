AfterStep do
  @previous_step_time = @current_step_time
  @current_step_time = Time.now
  if previous_step_time && previous_step_time > (ENV.fetch('TIMEOUT'){ '7000' }).to_i
    raise "Step took too long: #{previous_step_time} ms"
  end
end
