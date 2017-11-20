module WeatherForecastHelper

    def build_tiles_and_dialogs(data)
        tiles_colors = ['lime', 'green', 'emerald', 'teal', 'blue', 'cyan', 'cobalt', 'indigo', 'violet', 'pink', 'magenta', 'crimson', 'red', 'orange', 'amber', 'yellow', 'brown', 'olive']
        tiles_html = []
        dialogs_html = []
        tile_color = 0;

        data["list"].each_with_index do |info, i|
            tile_color = 0 if i >= tiles_colors.length
            tiles_html << build_tile(
                i,
                tiles_colors[tile_color],
                Time.parse(info["dt_txt"]),
                info["main"]["temp"],
                info["main"]["temp_min"],
                info["weather"][0]["description"],
                info["weather"][0]["icon"])
            dialogs_html << build_dialog(
                i,
                tiles_colors[tile_color],
                Time.parse(info["dt_txt"]),
                info)
            tile_color += 1
        end

        [tiles_html.join().html_safe, dialogs_html.join().html_safe]
    end

    def build_tile(indx, tile_color, fcst_date, temp, temp_min, desc, icon)
        render partial: "weather_forecast/partials/weather_tile",
            locals: {
                indx: indx,
                tile_color: tile_color,
                fcst_date: fcst_date,
                temp: temp,
                temp_min: temp_min,
                description: desc,
                icon: icon
            }
    end

    def build_dialog(indx, tile_color, fcst_date, info)
        render partial: "weather_forecast/partials/tile_dialog",
            locals: {
                indx: indx,
                tile_color: tile_color,
                fcst_date: fcst_date,
                temp: info["main"]["temp"],
                temp_max: info["main"]["temp_max"],
                temp_min: info["main"]["temp_min"],
                pressure: info["main"]["pressure"],
                sea_level: info["main"]["sea_level"],
                grnd_level: info["main"]["grnd_level"],
                humidity: info["main"]["humidity"],
                description: info["weather"][0]["description"],
                icon: info["weather"][0]["icon"],
                clouds: info["clouds"]["all"],
                wind_speed: info["wind"]["speed"],
                wind_deg: info["wind"]["deg"]
            }
    end
end
