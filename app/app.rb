require 'erubis'

class App < Sinatra::Application
  get '/' do
    status 200
    body "UP AND RUNNING"
  end

  get '/activities' do
    content_type 'application/json'
    status 200
    body "#{PipedriveClient.activities}"
  end

  get '/activities/call_duration.html' do
    @stats = ActivityService.average_duration
    content_type 'text/html'
    status 200
    erb :activities
  end

  get '/activities/call_duration.json' do
    @stats = ActivityService.average_duration
    content_type 'application/json'
    status 200
    erb :call_duration
  end
end
