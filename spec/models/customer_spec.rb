require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:document) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:document) }
end
