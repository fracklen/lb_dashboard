require 'bundler'
require 'sinatra'
require 'yaml'
require 'require_all'

require_all 'app'
require_all 'lib'

configure :production do
  require 'sinatra-logentries'
end

map "/" do
  use Rack::ShowExceptions
  run Rack::Cascade.new([HealthCheckController, App, TopSales, EventsController])
end
