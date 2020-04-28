require 'rails_helper'

describe Manufacturer, type: :model do
  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
  context 'references' do
    it { should have_many(:car_models)}
  end

  context 'validate messages of' do
    it 'presence' do
      manufacturer = Manufacturer.new()

      manufacturer.save

      expect(manufacturer.errors[:name]).to include("não pode ficar em branco")
    end
    it 'uniqueness' do
      Manufacturer.create!(name: 'Fiat')
      manufacturer = Manufacturer.new(name: 'Fiat')

      manufacturer.save

      expect(manufacturer.errors[:name]).to include("já está em uso")
    end
  end
end
