require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    fiat = Manufacturer.create!(name: 'Fiat')
    hatch = CarCategory.create!(name: 'Hatch',
                                daily_rate: '50', 
                                car_insurance: '20',
                                third_part_insurance: '20')
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar novo modelo'

    fill_in 'Modelo', with: 'Uno'
    fill_in 'Ano', with: '2019'
    fill_in 'Motor', with: '1.0'
    fill_in 'Combustivel', with: 'flex'
    select 'Fiat', from: 'Fabricante'
    select 'Hatch', from: 'Categoria de carro'
    click_on 'Enviar'

    expect(page).to have_content('Uno')
    expect(page).to have_content('2019')
    expect(page).to have_content('1.0')
    expect(page).to have_content('flex')
    expect(page).to have_content('Uno')
    expect(page).to have_content('Hatch')
  end

  scenario 'with blank values' do
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar novo modelo'
          
    fill_in 'Modelo', with: ''
    fill_in 'Ano', with: ''
    fill_in 'Motor', with: ''
    fill_in 'Combustivel', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content('Modelo não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Motor não pode ficar em branco')
    expect(page).to have_content('Combustivel não pode ficar em branco')
    expect(page).to have_content('Fabricante é obrigatório(a)')
    expect(page).to have_content('Fabricante é obrigatório(a)')
  end
end
