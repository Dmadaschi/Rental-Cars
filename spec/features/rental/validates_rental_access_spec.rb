require 'rails_helper'

feature 'Validates rental access' do
  context 'Admin singed in and' do
    scenario 'view index' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit rentals_path

      expect(current_path).to eq(rentals_path)
      expect(current_path).not_to eq(new_user_session_path)
    end

    scenario 'view new' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit new_rental_path

      expect(current_path).to eq(new_rental_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
  end
  context 'Admin not singed in and do not' do
    scenario 'view index' do
      visit rentals_path

      expect(current_path).not_to eq(rentals_path)
      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'view new' do
      visit new_rental_path

      expect(current_path).not_to eq(new_rental_path)
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
