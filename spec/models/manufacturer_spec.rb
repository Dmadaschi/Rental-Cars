require 'rails_helper'

describe Manufacturer, type: :model do
  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should have_many(:car_models)}
  end
end
