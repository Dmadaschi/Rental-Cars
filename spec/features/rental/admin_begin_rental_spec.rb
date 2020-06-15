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
    expect(page).to have_link('Iniciar Locação',
                              href: start_rental_path(rental.id))
  end

  scenario 'and view available cars' do
    user = create(:user)
    car_category = create(:car_category, name: 'B')
    fiat = create(:manufacturer, name: 'Fiat')
    mobi = create(:car_model, name: 'Mobi', manufacturer: fiat,
                              car_category: car_category)
    argos = create(:car_model, name: 'Argos', manufacturer: fiat)
    create(:car, car_model: mobi, license_plate: 'ABC-1234')
    create(:car, car_model: argos, license_plate: 'XYZ-9876', color: 'Preto')
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

  scenario 'successfully' do
    user = create(:user, email: 'test@test.com')
    car_category = create(:car_category, daily_rate: 100)
    fiat = create(:manufacturer, name: 'Fiat')
    mobi = create(:car_model, name: 'Mobi', manufacturer: fiat,
                              car_category: car_category)

    car = create(:car, car_model: mobi,
                       license_plate: 'ABC-1234', color: 'Azul')
    customer = create(:customer, name: 'Fulano Sicrano')

    rental = create(:rental, customer: customer, car_category: car_category)

    login_as(user, scope: :user)
    visit start_rental_path(rental.id)
    select 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul', from: 'Carro'

    travel_to Time.zone.local(2020, 05, 01, 13, 00, 00) do
      click_on 'Confirmar'
    end

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

  scenario 'from code search' do
    user = create(:user)
    car_category = create(:car_category)
    fiat = create(:manufacturer, name: 'Fiat')
    mobi = create(:car_model, name: 'Mobi', manufacturer: fiat,
                              car_category: car_category)
    car = create(:car, car_model: mobi, license_plate: 'ABC-123', color: 'Azul')
    rental = create(:rental, car_category: car_category)

    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Busca', with: rental.code
    click_on 'Pesquisar'
    click_on 'Iniciar'
    select 'Fiat Mobi - Placa: ABC-123 - Cor: Azul', from: 'Carro'
    click_on 'Confirmar'

    rental.reload
    car.reload
    expect(rental.ongoing?).to be true
    expect(car.rented?).to be true
    expect(current_path).to eq rental_path(rental.id)
    expect(page).to have_content 'Status Iniciada'
    expect(page).to have_content 'Carro Retirado: Fiat Mobi - Placa: ABC-123 - Cor: Azul'
  end

  scenario 'with status other than scheduled' do
    user = create(:user)
    rental = create(:rental, status: 'ongoing')
    create(:car_rental, rental: rental)

    login_as(user, scope: :user)
    visit rental_path(rental)

    expect(page).to_not have_content 'Iniciar'
  end

  scenario 'with add ons' do
    user = create(:user, email: 'test@test.com')
    car_category = create(:car_category, daily_rate: 100, car_insurance: 10,
                                         third_part_insurance: 10)
    fiat = create(:manufacturer, name: 'Fiat')
    mobi = create(:car_model, name: 'Mobi', manufacturer: fiat,
                              car_category: car_category)
    car = create(:car, car_model: mobi,
                       license_plate: 'ABC-1234', color: 'Azul')
    rental = create(:rental, car_category: car_category)
    add_ons = create_list(:add_on, 2, daily_rate: 10)

    login_as(user, scope: :user)
    visit start_rental_path(rental.id)
    select 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul', from: 'Carro'
    check add_ons.first.name
    check add_ons.last.name
    click_on 'Confirmar'

    expect(page).to have_content 'Status Iniciada'
    expect(page).to have_content 'Valor da Diária: R$ 120,00'
  end
end
