# isitraininginbelfast.com

Single serving site based upon the [Yahoo! weather report for Belfast](http://weather.yahoo.com/northern-ireland/belfast/belfast-44544)

## Install dependencies with Bundler

	bundle install

Requires a running Redis instance

## Run the app

	bundle exec rackup ./config.ru -p 3000

Browse to [http://0.0.0.0:3000](http://0.0.0.0:3000)

## Update the forecast

Perform a POST request to ``/update``

	curl -X POST -d '' http://0.0.0.0:3000/update
