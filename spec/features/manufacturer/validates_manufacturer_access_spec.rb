require 'rails_helper'

feature 'Validates manufacturer access' do
  context 'Admin singed in and' do
    scenario 'view index' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit manufacturers_path

      expect(current_path).to eq(manufacturers_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view new' do
      user = User.create!(email:'teste@teste.com', password: '12345678')

      login_as(user, scope: :user)
      visit new_manufacturer_path

      expect(current_path).to eq(new_manufacturer_path)
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view edit' do
      user = User.create!(email:'teste@teste.com', password: '12345678')
      manufacturer = Manufacturer.create!(name: 'Fiat')

      login_as(user, scope: :user)
      visit edit_manufacturer_path(manufacturer)

      expect(current_path).to eq(edit_manufacturer_path(manufacturer.id))
      expect(current_path).not_to eq(new_user_session_path)
    end
    scenario 'view show' do
      user = User.create!(email:'teste@teste.com', password: '12345678')
      manufacturer = Manufacturer.create!(name: 'Fiat')

      login_as(user, scope: :user)
      visit manufacturer_path(manufacturer)

      expect(current_path).to eq(manufacturer_path(manufacturer))
      expect(current_path).not_to eq(new_user_session_path)
    end
  end
  context 'Admin not singed in and do not' do
    scenario 'view index' do
      visit manufacturers_path

      expect(current_path).not_to eq(manufacturers_path)
      expect(current_path).to eq(new_user_session_path)
    end
    scenario 'view new' do

      visit new_manufacturer_path

      expect(current_path).not_to eq(new_manufacturer_path)
      expect(current_path).to eq(new_user_session_path)
    end
    scenario 'view edit' do
      manufacturer = Manufacturer.create!(name: 'Fiat')

      visit edit_manufacturer_path(manufacturer)

      expect(current_path).not_to eq(edit_manufacturer_path(manufacturer.id))
      expect(current_path).to eq(new_user_session_path)
    end
    scenario 'view show' do
      manufacturer = Manufacturer.create!(name: 'Fiat')

      visit manufacturer_path(manufacturer)

      expect(current_path).not_to eq(manufacturer_path(manufacturer))
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
