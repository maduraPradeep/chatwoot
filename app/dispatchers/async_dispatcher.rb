class AsyncDispatcher < BaseDispatcher
  def dispatch(event_name, timestamp, data)
    event_object = Events::Base.new(event_name, timestamp, data)
    publish(event_object.method_name, event_object)
  end

  def listeners
    listeners = [ReportingListener.instance]
    listeners << SubscriptionListener.instance if ENV['BILLING_ENABLED']
    listeners
  end
end
