require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WeatherForecastHelper. For example:
#
# describe WeatherForecastHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe WeatherForecastHelper, type: :helper do
    describe "#build_tiles_and_dialogs" do
        let(:data) {{"list"=>[
                {"dt"=>1511233200,
                  "main"=>
                   {"temp"=>1,
                    "temp_min"=>1,
                    "temp_max"=>1,
                    "pressure"=>1,
                    "sea_level"=>1,
                    "grnd_level"=>1,
                    "humidity"=>1,
                    "temp_kf"=>1},
                  "weather"=>
                   [{"id"=>1, "main"=>"Clear", "description"=>"Clear Sky", "icon"=>"moon"}],
                  "clouds"=>{"all"=>0},
                  "wind"=>{"speed"=>1, "deg"=>1},
                  "rain"=>{},
                  "sys"=>{"pod"=>"n"},
                  "dt_txt"=>"2017-11-21 03:00:00"},
                 {"dt"=>1511244000,
                  "main"=>
                   {"temp"=>2,
                    "temp_min"=>2,
                    "temp_max"=>2,
                    "pressure"=>2,
                    "sea_level"=>2,
                    "grnd_level"=>2,
                    "humidity"=>2,
                    "temp_kf"=>2},
                  "weather"=>
                   [{"id"=>2, "main"=>"Clear", "description"=>"Clear Sky", "icon"=>"moon"}],
                  "clouds"=>{"all"=>0},
                  "wind"=>{"speed"=>2, "deg"=>2},
                  "rain"=>{},
                  "sys"=>{"pod"=>"n"},
                  "dt_txt"=>"2017-11-21 06:00:00"
                }
            ]}
        }

        context "when the Open Weather Map API data is passed" do
            it "returns in Array[0] all tiles html" do
                tile_1 = build_tile(0, TILES_COLORS[0], Time.parse("2017-11-21 03:00:00"), 1, 1, "Clear Sky", "moon")
                tile_2 = build_tile(1, TILES_COLORS[1], Time.parse("2017-11-21 06:00:00"), 2, 2, "Clear Sky", "moon")
                expected_result = [tile_1, tile_2].join().html_safe
                expect(build_tiles_and_dialogs(data)[0]).to eq(expected_result)
            end

            it "returns in Array[1] all dialogs html" do
                dialog_1 = build_dialog(0, TILES_COLORS[0], Time.parse("2017-11-21 03:00:00"), data["list"][0])
                dialog_2 = build_dialog(1, TILES_COLORS[1], Time.parse("2017-11-21 06:00:00"), data["list"][1])
                expected_result = [dialog_1, dialog_2].join().html_safe
                expect(build_tiles_and_dialogs(data)[1]).to eq(expected_result)
            end
        end
    end

    describe "#build_tile" do
        let(:indx) {0}
        let(:tile_color) {TILES_COLORS[0]}
        let(:fcst_date) {Time.parse("2017-11-21 03:00:00")}
        let(:temp) {1}
        let(:temp_min) {1}
        let(:desc) {"Clear Sky"}
        let(:icon) {"moon"}

        it "returns a built tile html" do
            expected_result = render partial: "weather_forecast/partials/weather_tile",
                locals: {
                    indx: indx,
                    tile_color: tile_color,
                    fcst_date: fcst_date,
                    temp: temp,
                    temp_min: temp_min,
                    description: desc,
                    icon: icon
                }
            expect(build_tile(indx, tile_color, fcst_date, temp, temp_min, desc, icon)).to eq(expected_result)
        end


    end

    describe "#build_dialog" do
        let(:indx) {0}
        let(:tile_color) {TILES_COLORS[0]}
        let(:fcst_date) {Time.parse("2017-11-21 03:00:00")}
        let(:info) {
            {
                "dt"=>1511233200,
                "main"=>{"temp"=>1,"temp_min"=>1,"temp_max"=>1,"pressure"=>1,"sea_level"=>1,"grnd_level"=>1,"humidity"=>1,"temp_kf"=>1},
                "weather"=>[{"id"=>1, "main"=>"Clear", "description"=>"Clear Sky", "icon"=>"moon"}],
                "clouds"=>{"all"=>0},
                "wind"=>{"speed"=>1, "deg"=>1},
                "rain"=>{},
                "sys"=>{"pod"=>"n"},
                "dt_txt"=>"2017-11-21 03:00:00"
            }
        }

        it "returns a built dialog html" do
            expected_result = render partial: "weather_forecast/partials/tile_dialog",
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
            expect(build_dialog(indx, tile_color, fcst_date, info)).to eq(expected_result)
        end
    end
end
