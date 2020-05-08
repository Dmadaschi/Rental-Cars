require 'rails_helper'

RSpec.describe Subsidiary, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:cnpj) }
  end

  context 'validate messages of' do
    it 'presence' do
      subsidiary = Subsidiary.new()
      subsidiary.save

      expect(subsidiary.errors[:name]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:address]).to include('não pode ficar em branco')
    end

    it 'uniqueness' do
      cnpj = CNPJ.generate
      create(:subsidiary, name: 'Paulista', cnpj: cnpj)
      subsidiary = build(:subsidiary, name: 'Paulista', cnpj: cnpj)
      subsidiary.save
      
      expect(subsidiary.errors[:name]).to include('já está em uso')
      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'invalid cnpj' do
      subsidiary = build(:subsidiary, cnpj: '1111111111')
      subsidiary.save

      expect(subsidiary.errors[:cnpj]).to include('Digite um CNPJ valido')
    end
  end
end
