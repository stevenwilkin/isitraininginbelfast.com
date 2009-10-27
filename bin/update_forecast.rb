#!/usr/bin/env ruby

# get the filename of the weather symbol of the current forecast and write to disk
# SJW

require 'net/http'
require 'rubygems'
require 'hpricot'

# file to output currently forecast weather symbol to
OUTPUT = File.dirname(__FILE__) + '/../var/forecast.dat'

# the forecast page
URL = 'http://www.metoffice.gov.uk/weather/uk/ni/belfast_forecast_weather.html'

uri = URI.parse(URL)

Net::HTTP.start(uri.host) do |http|
	# GET the forecast page
	res = http.get(uri.path)
	exit unless res.code == '200'
	$doc = Hpricot(res.body)
	# find the first weather symbol in the 5-day forecast
	img = $doc.search("div.tableWrapper/table/tr[3]/td[2]/img").first
	src = img.attributes['src']
	# get filename, ensure is NAME.EXTENSION format and write to disk
	if src =~ /.+\/(\w+\.\w+)/
		open(OUTPUT, 'w'){|f| f.write($1)}
	end
end

