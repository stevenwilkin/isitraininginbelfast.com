#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

# list of possible conditions: http://developer.yahoo.com/weather/#codes
#doc = Nokogiri::XML(File.read('belfast.rss'))

VAR = File.expand_path(File.join(File.dirname(__FILE__), '..', 'var'))
TMP = File.join(VAR, 'forecast.tmp')
DAT = File.join(VAR, 'forecast.dat')

FEED = 'http://weather.yahooapis.com/forecastrss?w=44544'
doc = Nokogiri::XML(open(FEED))

# current weather condition
condition = doc.xpath('//yweather:condition').attr('text').value

condition =~ /rain|shower|storm/i
is_raining = !$~.nil?

# write to temp file first and then move it to where the frontend will access it
File.open(TMP, 'w') do |f|
	f.print is_raining
end

system("mv #{TMP} #{DAT}")
