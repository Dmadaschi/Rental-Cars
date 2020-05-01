require 'rails_helper'

feature 'Validates customer access' do
  context 'Admin singed in and' do
    scenario 'view index' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit customers_path

      expect(current_path).to eq(customers_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view new' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit new_customer_path

      expect(current_path).to eq(new_customer_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view show' do
      user = User.create!(email:'teste@teste.com', password: '12345678')
      customer = Customer.create!(name: 'João',
                                  document: '348.586.730-65', 
                                  email: 'joao@teste.com.br')

      login_as(user, scope: :user)
      visit customer_path(customer)

      expect(current_path).to eq(customer_path(customer))
      expect(current_path).not_to eq(new_user_session_path)
    end
  end
  context 'Admin not singed in and do not' do
    scenario 'view index' do
      visit customers_path

      expect(current_path).not_to eq(customers_path)
      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'view new' do
      visit new_customer_path

      expect(current_path).not_to eq(new_customer_path)
      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'view show' do
      customer = Customer.create!(name: 'João',
                                  document: '348.586.730-65', 
                                  email: 'joao@teste.com.br')

      visit customer_path(customer)

      expect(current_path).not_to eq(customer_path(customer))
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
