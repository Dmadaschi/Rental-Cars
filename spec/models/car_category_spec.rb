require 'rails_helper'

RSpec.describe CarCategory, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:daily_rate) }
    it { should validate_presence_of(:car_insurance) }
    it { should validate_presence_of(:third_part_insurance) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:daily_rate).is_greater_than(0) }
    it { should validate_numericality_of(:car_insurance).is_greater_than(0) }
    it { should validate_numericality_of(:third_part_insurance)
                 .is_greater_than(0) }
  end
  
  context 'references' do
    it { should have_many(:car_models)}
  end

  context 'validate messages of' do
    it 'presence' do
      car_category = CarCategory.new()

      car_category.save

      expect(car_category.errors[:name]).to include("não pode ficar em branco")
      expect(car_category.errors[:daily_rate]).to include("não pode ficar em branco")
      expect(car_category.errors[:car_insurance]).to include("não pode ficar em branco")
      expect(car_category.errors[:third_part_insurance]).to include("não pode ficar em branco")
    end

    it 'uniqueness' do
      create(:car_category, name: 'A')
      car_category = build(:car_category, name: 'A')

      car_category.save

      expect(car_category.errors[:name]).to include("já está em uso")
    end

    it 'greater_than' do
      car_category = build(:car_category, daily_rate: '0',
                           car_insurance: '0', third_part_insurance: '0')
      car_category.save                               

      expect(car_category.errors[:daily_rate]).to include("deve ser maior que 0")
      expect(car_category.errors[:car_insurance]).to include("deve ser maior que 0")
      expect(car_category.errors[:third_part_insurance]).to include("deve ser maior que 0")
    end
  end
end
