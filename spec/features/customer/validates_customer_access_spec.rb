require 'rails_helper'

feature 'Validates customer access' do
  context 'Admin singed in and' do
    scenario 'view index' do
      user = create(:user)

      login_as(user, scope: :user)
      visit customers_path

      expect(current_path).to eq(customers_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view new' do
      user = create(:user)

      login_as(user, scope: :user)
      visit new_customer_path

      expect(current_path).to eq(new_customer_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view show' do
      user = create(:user)
      customer = create(:customer)

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
      customer = create(:customer)

      visit customer_path(customer)

      expect(current_path).not_to eq(customer_path(customer))
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
