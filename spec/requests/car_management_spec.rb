require 'rails_helper'

describe 'car management' do
  context '#index' do
    it 'renders available cars' do
      cars = create_list(:car, 3, status: :available)
      rented_cars = create_list(:car, 3, status: :rented)

      get api_v1_cars_path

      response_json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response_json[0][:license_plate]).to eq(cars.first.license_plate)
      expect(response_json[1][:license_plate]).to eq(cars.second.license_plate)
      expect(response_json[2][:license_plate]).to eq(cars.third.license_plate)
      expect(response_json[0][:car_model_id]).to eq(cars.first.car_model_id)
      expect(response_json[1][:car_model_id]).to eq(cars.second.car_model_id)
      expect(response_json[2][:car_model_id]).to eq(cars.third.car_model_id)
      expect(response_json[0][:mileage]).to eq(cars.first.mileage)
      expect(response_json[1][:mileage]).to eq(cars.second.mileage)
      expect(response_json[2][:mileage]).to eq(cars.third.mileage)
      expect(response_json[0][:color]).to eq(cars.first.color)
      expect(response_json[1][:color]).to eq(cars.second.color)
      expect(response_json[2][:color]).to eq(cars.third.color)
      expect(response_json[0][:status]).to eq('available')
      expect(response_json[1][:status]).to eq('available')
      expect(response_json[2][:status]).to eq('available')
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

  context '#show' do
    context 'record exists' do
      let(:car) { create(:car) }

      before { get api_v1_car_path(car.id) }

      it 'return status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'return status car' do
        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response.content_type).to include('application/json')
        expect(response_json[:id]).to eq(car.id)
        expect(response_json[:license_plate]).to eq(car.license_plate)
        expect(response_json[:color]).to eq(car.color)
        expect(response_json[:car_model_id]).to eq(car.car_model_id)
        expect(response_json[:mileage]).to eq(car.mileage)
        expect(response_json[:status]).to eq(car.status)
      end
    end

    context 'when record exists' do
      before { get api_v1_car_path(id: 0000) }

      it 'return status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'return not found message' do
        expect(response.body).to include('Carro não encontrado')
      end
    end
  end

  context '#create' do
    context 'with valid parameters' do
      let(:car_model) { create(:car_model) }
      let(:attributes) { attributes_for :car, car_model_id: car_model.id }

      before { post api_v1_cars_path, params: { car: attributes } }

      it 'returns status 201' do
        expect(response).to have_http_status(:created)
      end

      it 'creates a car' do
        car = JSON.parse(response.body, symbolize_names: true)
        expect(car[:license_plate]).to eq(attributes[:license_plate])
        expect(car[:color]).to eq(attributes[:color])
        expect(car[:mileage]).to eq(attributes[:mileage])
        expect(car[:car_model_id]).to eq(attributes[:car_model_id])
      end
    end

    context 'with invalid parameters' do
      it 'returns missing parameters messages' do
        post api_v1_cars_path, params: { car: {} }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Parâmetros invalidos')
      end
    end
  end
end
