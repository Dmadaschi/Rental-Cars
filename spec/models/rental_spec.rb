require 'rails_helper'

RSpec.describe Rental, type: :model do
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
end