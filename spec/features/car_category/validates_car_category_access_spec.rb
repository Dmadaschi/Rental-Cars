require 'rails_helper'

feature 'Validates car_category access' do
  context 'Admin singed in and' do
    scenario 'view index' do
      user = create(:user)

      login_as(user, scope: :user)
      visit car_categories_path

      expect(current_path).to eq(car_categories_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view new' do
      user = create(:user)

      login_as(user, scope: :user)
      visit new_car_category_path

      expect(current_path).to eq(new_car_category_path)
      expect(current_path).not_to eq(new_user_session_path)
    end

    scenario 'view show' do
      user = create(:user)
      car_category = create(:car_category)

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
      car_category = create(:car_category)

      visit car_category_path(car_category)

      expect(current_path).not_to eq(car_category_path(car_category))
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
