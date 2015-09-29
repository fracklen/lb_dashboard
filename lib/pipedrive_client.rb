require 'active_support/all'
require 'faraday'

class PipedriveClient
  class << self
    def activities(options = {})
      new.activities(options)
    end

    def deals(options = {})
      new.deals(options)
    end

    def users(options = {})
      new.users(options)
    end

    def user(id, options = {})
      new.user(id, options)
    end
  end

  def initialize()

  end

  def deals(options)
    get('/v1/deals', options)['data'] || []
  end

  def activities(options)
    get('/v1/activities', options)['data'] || []
  end

  def activity(id, options)
    get("/v1/activities/#{id}", options)['data'] || []
  end

  def users(options)
    get('/v1/users', options)['data']
  end

  def user(id, options)
    get("/v1/users/#{id}", options)['data']
  end


  def get(url, options = {})
    uri = "#{url}?api_token=#{api_key}"

    options.each do |key, value|
      uri += "&#{key}=#{value}"
    end

    JSON.parse(client.get(uri).body)
  end

  def client
    @client ||= Faraday.new(:url => base_url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def api_key
    ENV['PIPEDRIVE_API_KEY']
  end

  def base_url
    'https://api.pipedrive.com'
  end
end
