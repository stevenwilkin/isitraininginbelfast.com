#!/usr/bin/env ruby

# retrieve all the weather symbols used by the MET office forecast and store the 
# file names and symbol descriptions which will be used in the PHP front-end
# SJW

require 'net/http'
require 'rubygems'
require 'hpricot'

# destination for the saved files
IMG_DIR	= File.dirname(__FILE__) + '/../www/img/'
# file to symbol details to
LOG = File.dirname(__FILE__) + '/../var/images.dat'
# the page listing all the symbols
URL = 'http://www.metoffice.gov.uk/weather/uk/guide/key.html'

uri = URI.parse(URL)
log = open(LOG, 'w')

Net::HTTP.start(uri.host) do |http|
	# GET the page
	res = http.get(uri.path)
	doc = Hpricot(res.body)
	# find all the images within the specific table
	doc.search("div#mainContent/table[2]//img").each do |img|
		src = img.attributes['src']
		alt = img.attributes['alt']
		# most filenames used on forecast page are slightly different to ones used on legend page
		# eg legend: w8x15.gif forecast: w8.gif
		src =~ /.*\/(.*)/
		orig_filename = $1
		if orig_filename =~ /(.+)x.+(\..+)/ 
			local_filename = $1 + $2
		else
			local_filename = orig_filename
		end
		# GET the image, safe locally and log details
		puts "Retrieving: #{orig_filename}"
		res = http.get(src)
		open(IMG_DIR + local_filename, 'wb'){ |f| f.write(res.body)}
		puts "Saved: #{local_filename}"
		log.puts("'#{local_filename}'\t=> '#{alt}',")
	end
end

log.close
