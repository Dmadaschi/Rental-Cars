require 'rails_helper'

RSpec.describe CarModel, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:motorization) }
  it { should validate_presence_of(:fuel_type) }
  it { should belong_to(:manufacturer) }
  it { should belong_to(:car_category) }
end
