require 'rails_helper'

RSpec.describe AddOn, type: :model do
  context 'references' do
    it { should have_many(:add_on_car_rentals) }
    it { should have_many(:car_rentals) }
  end
end
