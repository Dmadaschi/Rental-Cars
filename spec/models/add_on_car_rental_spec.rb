require 'rails_helper'

RSpec.describe AddOnCarRental, type: :model do
  context 'references' do
    it { should belong_to(:car_rental) }
    it { should belong_to(:add_on) }
  end

  context 'validate messages of' do
    it 'presence' do
      add_on_car_rental = AddOnCarRental.new

      add_on_car_rental.save

      expect(add_on_car_rental.errors[:car_rental])
        .to include('é obrigatório(a)')
      expect(add_on_car_rental.errors[:add_on])
        .to include('é obrigatório(a)')
    end
  end
end
