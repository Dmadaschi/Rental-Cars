require 'rails_helper'

describe 'car management' do
  context 'index' do
    it 'render available cars' do
      cars = create_list(:car, 3)

      get api_v1_cars_path

      expect(response).to have_http_status(:ok)
      # expect(response.content_type).to have_http_status('application/json')
      expect(response.body).to include(cars.first.license_plate)
      expect(response.body).to include(cars.second.license_plate)
      expect(response.body).to include(cars.third.license_plate)
    end
  end
end
