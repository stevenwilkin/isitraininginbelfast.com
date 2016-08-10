require 'sinatra/base'
require 'redis'
require 'json'
require 'open-uri'

class App < Sinatra::Base
  set :logging, true

  helpers do
    def redis
      @redis ||= begin
        uri = URI.parse(ENV["REDISTOGO_URL"] || '')
        Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      end
    end

    def update
      # list of possible conditions: https://developer.yahoo.com/weather/documentation.html#codes
      doc = JSON.parse(open('https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%2044544&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys').read)
      results = doc["query"]["results"]

      if results
        condition = results["channel"]["item"]["condition"]["text"]
        condition =~ /rain|shower|storm/i
        redis.set('raining', !$~.nil?)
      else
        # maybe rate-limited?
        'no results'
      end
    end
  end

  get '/' do
    @is_raining = redis.get('raining') == 'true'
    erb :index
  end

  post '/update' do
    update
  end
end
