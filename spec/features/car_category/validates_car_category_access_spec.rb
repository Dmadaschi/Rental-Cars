require 'rails_helper'

feature 'Validates car_category access' do
  context 'Admin singed in and' do
    scenario 'view index' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit car_categories_path

      expect(current_path).to eq(car_categories_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view new' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit new_car_category_path

      expect(current_path).to eq(new_car_category_path)
      expect(current_path).not_to eq(new_user_session_path)
    end

    scenario 'view show' do
      user = User.create!(email:'teste@teste.com', password: '12345678')
      car_category = CarCategory.create!(name: 'A',
                                         daily_rate: '50', 
                                         car_insurance: '20',
                                         third_part_insurance: '20')

      login_as(user, scope: :user)
      visit car_category_path(car_category)

      expect(current_path).to eq(car_category_path(car_category))
      expect(current_path).not_to eq(new_user_session_path)
    end
  end
  context 'Admin not singed in and do not' do
    scenario 'view index' do
      visit car_categories_path

      expect(current_path).not_to eq(car_categories_path)
      expect(current_path).to eq(new_user_session_path)
    end
    scenario 'view new' do
      visit new_car_category_path

      expect(current_path).not_to eq(new_car_category_path)
      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'view show' do
      car_category = CarCategory.create!(name: 'A',
                                         daily_rate: '50', 
                                         car_insurance: '20',
                                         third_part_insurance: '20')

      visit car_category_path(car_category)

      expect(current_path).not_to eq(car_category_path(car_category))
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
