#!/usr/bin/env ruby

require 'redis'
require 'nokogiri'
require 'open-uri'

uri = URI.parse(ENV["REDISTOGO_URL"] || '')
redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

# list of possible conditions: http://developer.yahoo.com/weather/#codes
#doc = Nokogiri::XML(File.read('belfast.rss'))

FEED = 'http://weather.yahooapis.com/forecastrss?w=44544'
doc = Nokogiri::XML(open(FEED))

# current weather condition
condition = doc.xpath('//yweather:condition').attr('text').value

condition =~ /rain|shower|storm/i

redis.set('raining', !$~.nil?)
