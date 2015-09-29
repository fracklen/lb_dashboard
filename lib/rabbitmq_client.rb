require 'lbunny'

rabbit_url = ENV.fetch('RABBITMQ_URL', 'amqp://guest:guest@localhost:5672')
RabbitMQClient = Lbunny::Client.new(rabbit_url) do |error|
  Raven.capture_exception(error)
end
