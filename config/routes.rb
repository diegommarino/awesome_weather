Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "weather_forecast#index"

  get '/index', to: 'weather_forecast#index'
end
