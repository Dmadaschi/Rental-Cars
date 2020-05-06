require 'rails_helper'

feature 'User search_rental' do
  scenario 'seccessfully' do
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

    another_rental = Rental.create!(start_date: '16/04/2030',
                                end_date: '18/04/2030',
                                customer: customer,
                                car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'
    fill_in 'Busca',	with: rental.code
    click_on 'Pesquisar'

    expect(page).to have_content(rental.code)
    expect(page).not_to have_content(another_rental.code)
  end

  scenario 'with invalid code' do
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
    another_rental = Rental.create!(start_date: '16/04/2030',
                                end_date: '18/04/2030',
                                customer: customer,
                                car_category: car_category)
    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Busca',	with: "12345678910"
    click_on 'Pesquisar'
    expect(page).to have_content("Nenhuma locação encontrada com este código")
    expect(page).to have_content(rental.code)
    expect(page).to have_content(another_rental.code)
  end
end
