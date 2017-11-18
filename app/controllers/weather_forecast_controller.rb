class WeatherForecastController < ApplicationController
    def index
        @city = params[:city]

        if @city.present?
            require 'httparty'
            require 'json'

            url = "http://api.openweathermap.org/data/2.5/forecast?q=#{@city}&units=metric&APPID=#{ENV["open_weather_api_key"]}"
            response = HTTParty.get(url)
            @data = response.parsed_response
            if @data["cod"] == "200"
                @data["json_list"] = @data["list"][0..15].to_json
                wind = @data["list"][0]["wind"]["speed"]
                temp = @data["list"][0]["main"]["temp"]
                @data["feels_like"] = feels_like_temperature(wind, temp)
            end
        else
            @data = nil
        end

        respond_to do |format|
            format.html
            format.js
        end
    end

    private

    def feels_like_temperature(wind, temperature)
        if wind < 4.8
            return temperature
        else
            return (13.12 + (0.6215 * temperature) - ((11.37 * wind) ** 0.16)\
                + ((0.3965 * temperature * wind) ** 0.16)).round(2)
        end
    end
end
