require 'rails_helper'

RSpec.describe CarModel, type: :model do
  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:motorization) }
    it { should validate_presence_of(:fuel_type) }
  end

  context 'references' do
    it { should belong_to(:manufacturer) }
    it { should belong_to(:car_category) }
  end

  context 'validate messages of' do
    it 'presence' do
      car_model = CarModel.new()

      car_model.save

      expect(car_model.errors[:name]).to include("não pode ficar em branco")
      expect(car_model.errors[:year]).to include("não pode ficar em branco")
      expect(car_model.errors[:motorization]).to include("não pode ficar em branco")
      expect(car_model.errors[:fuel_type]).to include("não pode ficar em branco")
      expect(car_model.errors[:manufacturer]).to include("é obrigatório(a)")
      expect(car_model.errors[:car_category]).to include("é obrigatório(a)")
    end
  end
end
