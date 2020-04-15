require 'rails_helper'

RSpec.describe Subsidiary, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:cnpj) }
  end
end
