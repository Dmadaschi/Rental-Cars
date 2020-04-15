require 'rails_helper'

feature 'Admin view car model' do
  scenario 'successfully' do
    fiat = Manufacturer.create!(name: 'Fiat')
    hatch = CarCategory.create!(name: 'Hatch',
                                daily_rate: '50', 
                                car_insurance: '20',
                                third_part_insurance: '20')
    CarModel.create!(name: 'Uno',
                     year: '2019',
                     motorization: '32',
                     fuel_type: 'flex',
                     manufacturer: fiat,
                     car_category: hatch)
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Uno')
    expect(page).to have_content('2019')
    expect(page).to have_content('32')
    expect(page).to have_content('flex')
    expect(page).to have_content('Hatch')
    expect(page).to have_content('Fiat')
  end

  scenario 'whith multiples car models' do
    fiat = Manufacturer.create!(name: 'Fiat')
    hatch = CarCategory.create!(name: 'Hatch',
                                daily_rate: '50', 
                                car_insurance: '20',
                                third_part_insurance: '20')
    honda = Manufacturer.create!(name: 'Honda')
    sedan = CarCategory.create!(name: 'Sedan',
                                daily_rate: '50', 
                                car_insurance: '20',
                                third_part_insurance: '20')
    CarModel.create!(name: 'Uno',
                     year: '2019',
                     motorization: '32',
                     fuel_type: 'flex',
                     manufacturer: fiat,
                     car_category: hatch)
    CarModel.create!(name: 'City',
                     year: '2020',
                     motorization: '62',
                     fuel_type: 'gasolina',
                     manufacturer: honda,
                     car_category: sedan)                 
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Uno')
    expect(page).to have_content('2019')
    expect(page).to have_content('32')
    expect(page).to have_content('flex')
    expect(page).to have_content('Sedan')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('City')
    expect(page).to have_content('2020')
    expect(page).to have_content('62')
    expect(page).to have_content('gasolina')
    expect(page).to have_content('Sedan')
    expect(page).to have_content('Honda')
  end

  scenario 'with no car model' do
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end

  scenario 'and redirtect to manufacturer' do
    fiat = Manufacturer.create!(name: 'Fiat')
    hatch = CarCategory.create!(name: 'Hatch',
                                daily_rate: '50', 
                                car_insurance: '20',
                                third_part_insurance: '20')
    CarModel.create!(name: 'Uno',
                     year: '2019',
                     motorization: '32',
                     fuel_type: 'flex',
                     manufacturer: fiat,
                     car_category: hatch)

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).not_to have_content('Uno')
    expect(page).not_to have_content('Hatch')
  end

  scenario 'and redirtect to manufacturer' do
    fiat = Manufacturer.create!(name: 'Fiat')
    hatch = CarCategory.create!(name: 'Hatch',
                                daily_rate: '50', 
                                car_insurance: '20',
                                third_part_insurance: '20')
    CarModel.create!(name: 'Uno',
                     year: '2019',
                     motorization: '32',
                     fuel_type: 'flex',
                     manufacturer: fiat,
                     car_category: hatch)

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Hatch'

    expect(page).to have_content('Hatch')
    expect(page).not_to have_content('Fiat')
    expect(page).not_to have_content('Uno')
  end

  scenario 'and return to home' do
    fiat = Manufacturer.create!(name: 'Fiat')
    hatch = CarCategory.create!(name: 'Hatch',
                                daily_rate: '50', 
                                car_insurance: '20',
                                third_part_insurance: '20')
    CarModel.create!(name: 'Uno',
                     year: '2019',
                     motorization: '32',
                     fuel_type: 'flex',
                     manufacturer: fiat,
                     car_category: hatch)

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

end
