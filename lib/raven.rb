require 'raven'

Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN'] unless ENV['SENTRY_DSN'].nil?
  config.silence_ready = true
  config.logger = ::Logger.new('/dev/null')
end
