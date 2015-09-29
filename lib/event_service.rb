class EventService
  attr_reader :event

  class << self
    def publish(event)
      new(event).publish
    end
  end

  def initialize(event)
    @event = event
  end

  def publish
    RabbitMQClient.publish(formatted_event, options)
  end

  private

  def formatted_event
    event.to_json
  end

  def options
    {
      routing_key:  routing_key,
      type:         routing_key,
      app_id:       "lb_dashboard",
      persistent:   true,
      content_type: 'application/json',
      timestamp:    Time.now.to_i
    }
  end

  def routing_key
    "pipedrive.#{event['event']}"
  end
end
