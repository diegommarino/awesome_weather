class WeatherForecastController < ApplicationController
    def index
        @city = params[:city]

        respond_to do |format|
          format.html
          format.js
        end
    end
end
