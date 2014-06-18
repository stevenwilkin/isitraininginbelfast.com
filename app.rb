require 'sinatra/base'

class App < Sinatra::Base
	set :logging, true

	get '/' do
		dat = File.expand_path(File.join(
			File.dirname(__FILE__), 'var', 'forecast.dat'))
		@is_raining = File.read(dat).strip == 'true'
		erb :index
	end

end
