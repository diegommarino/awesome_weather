require 'rails_helper'

RSpec.describe 'Weather Forecast Controller Requests', type: :request do
    describe 'GET /index', :vcr do
        before { get '/index', params: {} }

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
            expect(response).to render_template(:index)
        end

        context 'with valid city param' do
            before { get '/index', params: {city: "Fortaleza"} }

            it 'return status code 200' do
                expect(response).to have_http_status(200)
                expect(response).to render_template(:index)
            end
        end

        context 'with invalid city param' do
            before { get '/index', params: {city: "Invalid City"} }

            it 'return status code 200' do
                expect(response).to have_http_status(200)
                expect(response).to render_template(:index)
            end
        end
    end
end
