require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'validation' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end
  
  context 'references' do
    it { should belong_to(:customer) }
    it { should belong_to(:car_category) }
  end

  context 'validate messages of' do
    it 'presence' do
      rental = Rental.new()
      rental.save

      expect(rental.errors[:start_date]).to include('não pode ficar em branco')
      expect(rental.errors[:end_date]).to include('não pode ficar em branco')
      expect(rental.errors[:customer]).to include('é obrigatório(a)')
      expect(rental.errors[:car_category]).to include('é obrigatório(a)')
    end
  end

  context '#code' do
    it 'created automatically' do
      rental = create(:rental)
      
      expect(rental.code.size).to eq(6)
    end
  end

  context '#status' do
    it 'default to scheduled' do
      rental = create(:rental)

      expect(rental.scheduled?).to be true
    end
  end
end
