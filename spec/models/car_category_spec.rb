require 'rails_helper'

RSpec.describe CarCategory, type: :model do
  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:daily_rate) }
    it { should validate_presence_of(:car_insurance) }
    it { should validate_presence_of(:third_part_insurance) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:daily_rate).is_greater_than(0) }
    it { should validate_numericality_of(:car_insurance).is_greater_than(0) }
    it { should validate_numericality_of(:third_part_insurance).is_greater_than(0) }
    it { should have_many(:car_models)}
  end
end
