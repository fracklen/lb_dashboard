class EventsController < Sinatra::Application
  before do
    content_type 'application/json'
    cache_control :no_cache
  end

  post '/event' do
    event = JSON.parse request.body.read
    EventService.publish(event)
    status 200
    body '{"status": "OK"}'
  end
end
