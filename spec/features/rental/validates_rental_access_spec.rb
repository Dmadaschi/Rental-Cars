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

    scenario 'search rental' do
      user = User.create!(email:'teste@teste.com', password: '12345678')
      customer = Customer.create!(name: 'João',
                                document: '348.586.730-65', 
                                email: 'joao@teste.com.br')
      car_category = CarCategory.create!(name: 'Hatch',
                                         daily_rate: '50', 
                                         car_insurance: '20',
                                         third_part_insurance: '20')
      rental = Rental.create!(start_date: '16/04/2030',
                              end_date: '18/04/2030',
                              customer: customer,
                              car_category: car_category)

      login_as(user, scope: :user)
      visit search_rentals_path(rental)

      expect(current_path).to eq(search_rentals_path(rental))
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
