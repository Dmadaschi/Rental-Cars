require 'rails_helper'

RSpec.describe CarRental, type: :model do
  context 'validations' do
    it { should validate_presence_of(:daily_rate) }
  end
  context 'references' do
    it { should belong_to(:car) }
    it { should belong_to(:rental) }
    it { should belong_to(:user) }
  end

  context 'validate messages of' do
    it 'presesence' do
      car_rental = CarRental.new

      car_rental.save

      expect(car_rental.errors[:daily_rate]).to include('não pode ficar em branco')
      expect(car_rental.errors[:rental]).to include('é obrigatório(a)')
      expect(car_rental.errors[:user]).to include('é obrigatório(a)')
      expect(car_rental.errors[:car]).to include('é obrigatório(a)')
    end
  end

  context 'start_date' do
    it 'must be today' do
      rental = create(:car_rental)

      expect(rental.start_date).to eq(Date.today)
    end
  end
end
