require 'rails_helper'

feature 'Admin view cars' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer, name: 'Ford')
    car_category = create(:car_category, name: 'Sedan')
    car_model = create(:car_model, manufacturer: manufacturer, name: 'Focus',
                                   car_category: car_category)
    create(:car, car_model: car_model, license_plate: 'ABC-123')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Veiculos'

    expect(page).to have_content('Fabricante')
    expect(page).to have_content('Modelo')
    expect(page).to have_content('Categoria')
    expect(page).to have_content('Placa')
    expect(page).to have_content('Status')
    expect(page).to have_content('Ford')
    expect(page).to have_content('Focus')
    expect(page).to have_content('Sedan')
    expect(page).to have_content('ABC-123')
    expect(page).to have_content('Disponivel')
  end

  scenario 'with multiple cars' do
    user = create(:user)
    manufacturer = create(:manufacturer, name: 'Ford')
    car_category = create(:car_category, name: 'Sedan')
    car_model = create(:car_model, manufacturer: manufacturer, name: 'Focus',
                                   car_category: car_category)
    create(:car, car_model: car_model, license_plate: 'ABC-123')

    manufacturer = create(:manufacturer, name: 'Fiat')
    car_category = create(:car_category, name: 'Hatch')
    car_model = create(:car_model, manufacturer: manufacturer, name: 'Argo',
                                   car_category: car_category)
    create(:car, car_model: car_model, license_plate: 'HKJ-549')
    login_as(user, scope: :user)
    visit cars_path

    expect(page).to have_content('Ford')
    expect(page).to have_content('Focus')
    expect(page).to have_content('Sedan')
    expect(page).to have_content('ABC-123')
    expect(page).to have_content('Disponivel')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('Argo')
    expect(page).to have_content('Hatch')
    expect(page).to have_content('HKJ-549')
    expect(page).to have_content('Disponivel')
  end

  scenario 'with no cars' do
    user = create(:user)
    login_as(user, scope: :user)
    visit cars_path

    expect(page).to have_content('Nenhum veiculo cadastrado')
  end

  scenario 'and return to home' do
    user = create(:user)
    login_as(user, scope: :user)
    visit cars_path
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and view details' do
    user = create(:user)
    manufacturer = create(:manufacturer, name: 'Ford')
    car_category = create(:car_category, name: 'Sedan')
    car_model = create(:car_model, manufacturer: manufacturer, name: 'Focus',
                                   car_category: car_category, year: '2020',
                                   motorization: '1.6', fuel_type: 'Flex')
    car = create(:car, car_model: car_model, license_plate: 'ABC-123',
                       mileage: '15000', color: 'Azul')
    login_as(user, scope: :user)
    visit cars_path
    click_on 'Detalhes'

    expect(current_path).to eq car_path(car)
    expect(page).to have_content('Ford Focus - 2020 - 1.6 - Flex')
    expect(page).to have_content('ABC-123')
    expect(page).to have_content('15000 km')
    expect(page).to have_content('Azul')
    expect(page).to have_content('Disponivel')
  end
end
