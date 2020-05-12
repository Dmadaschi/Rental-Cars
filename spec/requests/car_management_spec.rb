require 'rails_helper'

describe 'car management' do
  context 'index' do
    it 'renders available cars' do
      cars = create_list(:car, 3, status: :available)
      rented_cars = create_list(:car, 3, status: :rented)
      get api_v1_cars_path

      response_json = JSON.parse(response.body, simbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response_json[0]['license_plate']).to eq(cars.first.license_plate)
      expect(response_json[1]['license_plate']).to eq(cars.second.license_plate)
      expect(response_json[2]['license_plate']).to eq(cars.third.license_plate)
      expect(response_json).to_not include(rented_cars)
    end

    it 'renders empity json' do
      get api_v1_cars_path

      response_json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response_json).to be_blank
    end
  end
end
