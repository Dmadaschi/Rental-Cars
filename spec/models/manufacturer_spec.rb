require 'rails_helper'

describe Manufacturer, type: :model do
  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
  context 'references' do
    it { should have_many(:car_models)}
  end
end
