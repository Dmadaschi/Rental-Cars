require 'rails_helper'

feature 'Admin register rentals' do
  scenario 'successfully' do
    customer = Customer.create!(name: 'João',
                                document: '348.586.730-65', 
                                email: 'joao@teste.com.br')
    car_category = CarCategory.create!(name: 'Hatch',
                                       daily_rate: '50', 
                                       car_insurance: '20',
                                       third_part_insurance: '20')

    visit root_path
    click_on 'Locação'
    click_on 'Registrar nova locação'
    fill_in 'Data de inicio', with: '16/04/2030'
    fill_in 'Data final', with: '18/04/2030'
    select customer.identification, from: 'Cliente'
    select car_category.name, from: 'Categoria de carro'
    click_on 'Enviar'



    expect(page).to have_content('16/04/2030')
    expect(page).to have_content('18/04/2030')
    expect(page).to have_content(customer.identification)
    expect(page).to have_content(car_category.name)
  end
end
