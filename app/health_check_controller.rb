class HealthCheckController < Sinatra::Application
  before do
    content_type 'text/plain'
    cache_control :no_cache
  end

  get '/health_check' do
    status 200
    body 'OK'
  end
end
