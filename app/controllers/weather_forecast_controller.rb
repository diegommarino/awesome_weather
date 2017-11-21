class WeatherForecastController < ApplicationController
    def index
        @city = params[:city]
        if @city.present?
            @data = get_weather_forecast(@city, "forecast")
            @data_now = get_weather_forecast(@city, "weather")
        else
            @data = {"cod" => 500}
        end

        respond_to do |format|
            format.html
            format.js
        end
    end

    private

    def get_weather_forecast(city, service)
        require 'httparty'
        require 'json'

        url = "http://api.openweathermap.org/data/2.5/#{service}?q=#{city}&units=metric&APPID=#{ENV["open_weather_api_key"]}"
        uri = URI.parse(URI.escape(url))
        response = HTTParty.get(uri)
        data = response.parsed_response

        if data["cod"].to_i == 200
            if service == "weather"
                data["list"] = change_default_icons_and_weather_title([data])
            else
                data["list"] = change_default_icons_and_weather_title(data["list"])[0..15]
            end
            wind = data["list"][0]["wind"]["speed"]
            temp = data["list"][0]["main"]["temp"]
            data["feels_like"] = feels_like_temperature(wind, temp)
        end

        data
    end

    def feels_like_temperature(wind, temperature)
        if wind < 4.8
            return temperature
        else
            return (13.12 + (0.6215 * temperature) - (11.37 * wind ** 0.16)\
                + (0.3965 * temperature * wind ** 0.16)).round(2)
        end
    end

    def change_default_icons_and_weather_title(data_list)
        data_list.each do |data_object|
            icon = data_object["weather"][0]["icon"]
            data_object["weather"][0]["icon"] = WEATHER_ICONS[icon]
            data_object["weather"][0]["description"] = data_object["weather"][0]["description"].titleize
        end
        data_list
    end
end
