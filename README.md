# Awesome Weather
![Build Status](https://travis-ci.org/diegommarino/awesome_weather.svg?branch=master)

Awesome weather shows the weather forecast by city for the next 48h divided in 16 previews.

## Technologies
Core
- Ruby 2.4.0
- Rails 5.1.4
- [Metro UI](https://metroui.org.ua/) 3.0.14

Tests
- [RSpec 3.7.0](https://relishapp.com/rspec/rspec-rails/v/3-7/docs/) 
- [VCR 3.0.3](https://relishapp.com/vcr/vcr/v/3-0-3/docs/)

Misc
- Yarn 1.3.2
- Node 8.2.1

## Testing localy

Requirements
- Rails >= 5.0
- Node >= 4.0
- [Open Weather Map](https://openweathermap.org/) API key
Clone this repo
```console
$ git clone https://github.com/diegommarino/awesome_weather.git
```

Inside the project install the gems and libs
```console
$ bundle install
$ npm install
```

Create config/application.yml file and add your open weather key in it
```console
$ touch config/application.yml
$ echo 'open_weather_api_key: API_KEY' >> config/application.yml
```

Run the application
```console
rails s
```
