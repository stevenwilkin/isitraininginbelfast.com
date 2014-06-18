require 'sinatra/base'
require 'redis'
require 'nokogiri'
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
      # list of possible conditions: http://developer.yahoo.com/weather/#codes
      doc = Nokogiri::XML(open('http://weather.yahooapis.com/forecastrss?w=44544'))
      # current weather condition
      condition = doc.xpath('//yweather:condition').attr('text').value
      condition =~ /rain|shower|storm/i
      redis.set('raining', !$~.nil?)
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
