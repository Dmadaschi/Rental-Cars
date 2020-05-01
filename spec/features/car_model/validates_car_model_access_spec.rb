require 'rails_helper'

feature 'Validates car_model access' do
  context 'Admin singed in and' do
    scenario 'view index' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit car_models_path

      expect(current_path).to eq(car_models_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view new' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit new_car_model_path

      expect(current_path).to eq(new_car_model_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
  end
  context 'Admin not singed in and do not' do
    scenario 'view index' do
      visit car_models_path

      expect(current_path).not_to eq(car_models_path)
      expect(current_path).to eq(new_user_session_path)
    end
    scenario 'view new' do
      visit new_car_model_path

      expect(current_path).not_to eq(new_car_model_path)
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
