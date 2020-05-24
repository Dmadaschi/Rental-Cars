require 'rails_helper'

feature 'Admin begin rental' do
  scenario 'from customer search' do
    user = create(:user)
    car_category = create(:car_category, name: 'B')
    customer = create(:customer)
    rental = create(:rental, customer: customer, car_category: car_category)

    login_as(user)
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: customer.document
    click_on 'Pesquisar'
    click_on customer.name

    expect(current_path).to eq customer_path(customer.id)
    expect(page).to have_content rental.code
    expect(page).to have_content 'Categoria B'
    expect(page).to have_link('Iniciar Locação', href: start_rental_path(rental.id))
  end

  scenario 'and view available cars' do
    user = create(:user)
    car_category = create(:car_category, name: 'B')
    fiat = create(:manufacturer, name: 'Fiat')
    mobi = create(:car_model, name: 'Mobi', manufacturer: fiat, car_category: car_category)
    argos = create(:car_model, name: 'Argos', manufacturer: fiat)
    car = create(:car, car_model: mobi, license_plate: 'ABC-1234')
    another_car = create(:car, car_model: argos, license_plate: 'XYZ-9876', color: 'Preto')
    rental = create(:rental, car_category: car_category)

    login_as(user, scope: :user)
    visit customer_path(rental.customer.id)
    click_on 'Iniciar Locação'

    expect(current_path).to eq start_rental_path(rental.id)
    expect(page).to have_content rental.code
    expect(page).to have_content 'Categoria B'
    expect(page).to have_content 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul'
    expect(page).not_to have_content 'Fiat Argos - Placa: XYZ-9876 - Cor: Preto'
  end

  xscenario 'successfully' do
    user = User.create!(email: 'test@test.com', password: '12345678')
    car_category = CarCategory.create!(name: 'A', daily_rate: 100, 
                                       car_insurance: 100, third_part_insurance: 100)

    fiat = Manufacturer.create!(name: 'Fiat')

    mobi = CarModel.create!(name: 'Mobi', manufacturer: fiat, car_category: car_category,
                            year: '2018', motorization: '38 cv', fuel_type: 'flex')

    car = Car.create(car_model: mobi, license_plate: 'ABC-1234', mileage: 1000, color: 'Azul')
    customer = Customer.create!(name: 'Fulano Sicrano', document: CPF.generate,
                                email: 'teste@teste.com.br')

    rental = Rental.create!(start_date: '16/04/2030', end_date: '18/04/2030',
                            customer: customer, car_category: car_category)

    login_as(user, scope: :user)
    visit start_rental_path(rental.id)
    select 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul', from: 'Carro'

    # travel_to Time.zone.local(2020, 05, 01, 13, 00, 00) do
    #   click_on 'Confirmar'
    # end

    rental.reload
    car.reload
    expect(rental.ongoing?).to be true
    expect(car.rented?).to be true
    expect(current_path).to eq rental_path(rental.id)
    expect(page).to have_content 'Status Iniciada'
    expect(page).to have_content 'Fulano Sicrano'
    expect(page).to have_content 'Horário da Retirada: 01/05/2020 13:00:00'
    expect(page).to have_content 'Usuário Responsável: test@test.com'
    expect(page).to have_content 'Carro Retirado: Fiat Mobi - Placa: ABC-1234 - Cor: Azul'
    expect(page).to have_content 'Valor da Diária: R$ 100,00'
  end
end