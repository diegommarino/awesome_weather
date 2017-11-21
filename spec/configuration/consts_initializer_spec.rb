require 'rails_helper'

RSpec.describe 'config/initializers/consts.rb', type: :controller do
    it "should exists a WEATHER_ICONS const" do
        expect(WEATHER_ICONS).to eq({
            '01d' => 'sun',
            '01n' => 'moon',
            '02d' => 'cloudy',
            '02n' => 'cloud2',
            '03d' => 'cloud3',
            '03n' => 'cloud3',
            '04d' => 'cloud2',
            '04n' => 'cloudy2',
            '09d' => 'weather4',
            '09n' => 'weather4',
            '10d' => 'rainy',
            '10n' => 'rainy',
            '11d' => 'cloud4',
            '11n' => 'cloud4',
            '13d' => 'snowy3',
            '13n' => 'snowy3',
            '50d' => 'weather3',
            '50n' => 'weather3'
        })
    end

    it "should exists a TILES_COLORS const" do
        expect(TILES_COLORS).to eq([
            'lime',
            'green',
            'emerald',
            'teal',
            'blue',
            'cyan',
            'cobalt',
            'indigo',
            'violet',
            'pink',
            'magenta',
            'crimson',
            'red',
            'orange',
            'amber',
            'yellow',
            'brown',
            'olive'
        ])
    end
end
