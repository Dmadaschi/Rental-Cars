require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:document) }  
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:document) }
  end

  context 'validate messages of' do
    it 'presence' do
      customer = Customer.new()

      customer.save

      expect(customer.errors[:name]).to include("não pode ficar em branco")
      expect(customer.errors[:email]).to include("não pode ficar em branco")
      expect(customer.errors[:document]).to include("não pode ficar em branco")
    end

    it 'uniqueness' do
      cpf = CPF.generate
      create(:customer, email: 'jorge@teste.com.br', document: cpf)
      customer = build(:customer, email: 'jorge@teste.com.br', document: cpf)

      customer.save

      expect(customer.errors[:email]).to include("já está em uso")
      expect(customer.errors[:document]).to include("já está em uso")
    end

    it 'invalid cpf' do
      customer = build(:customer, document: '999999999999')
      
      customer.save

      expect(customer.errors[:document]).to include("Digite um CPF valido")
    end
  end
end
