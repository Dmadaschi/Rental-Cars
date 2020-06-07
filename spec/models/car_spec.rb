require 'rails_helper'

RSpec.describe Car, type: :model do
  context 'validations' do
    it { should validate_presence_of(:license_plate) }
    it { should validate_presence_of(:mileage) }
    it { should validate_presence_of(:color) }
    it { should validate_numericality_of(:mileage) }
  end
  context 'references' do
    it { should belong_to(:car_model) }
    it { should have_many(:car_rentals) }
  end

  context 'validate messages of' do
    it 'presence' do
      car = Car.new

      car.save

      expect(car.errors[:license_plate]).to include('não pode ficar em branco')
      expect(car.errors[:mileage]).to include('não pode ficar em branco')
      expect(car.errors[:color]).to include('não pode ficar em branco')
      expect(car.errors[:car_model]).to include('é obrigatório(a)')
    end

    it 'numericality' do
      car = build(:car, mileage: 'mileage')

      car.save

      expect(car.errors[:mileage]).to include('não é um número')
    end

    it 'uniqueness' do
      create(:car, license_plate: 'ABC-123')

      car = build(:car, license_plate: 'ABC-123')

      car.save

      expect(car.errors[:license_plate]).to include('já está em uso')
    end
  end

  context 'methods' do
    it 'description' do
      manufacturer = create(:manufacturer, name: 'Fiat')
      car_model = create(:car_model, name: 'Uno', manufacturer: manufacturer)
      car = create(:car, license_plate: 'XAB-4534',
                         mileage: 1000, color: 'Preto', car_model: car_model)

      expect(car.description).to eq('Fiat Uno - Placa: XAB-4534 - Cor: Preto')
    end
  end
end
