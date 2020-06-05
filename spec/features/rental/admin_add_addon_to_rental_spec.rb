require 'rails_helper'

feature 'Admin add addon to rental' do
  scenario 'view addons' do
    user = create(:user)

    AddOn.create!(name: 'Carrinho de Bebê', daily_rate: 59,
                  serial_number: 'BEBE1234')
    AddOn.create!(name: 'Transporte para Bike', daily_rate: 29,
                  serial_number: 'BIKE999')

    rental = create(:rental)

    login_as(user, scope: :user)
    visit start_rental_path(rental.id)

    expect(page).to have_content 'Carrinho de Bebê'
    expect(page).to have_content 'Transporte para Bike'
  end

  scenario 'and choose addons' do
    # Arrange
    user = create(:user)

    car_category = create(:car_category)
    fiat = create(:manufacturer, name: 'Fiat')
    mobi = create(:car_model, name: 'Mobi', manufacturer: fiat, car_category: car_category)
    car = create(:car, car_model: mobi, license_plate: 'ABC-1234', color: 'Azul')

    addon = AddOn.create!(name: 'Carrinho de Bebê', daily_rate: 59, serial_number: 'BEBE1234')
    other_addon = AddOn.create!(name: 'Transporte para Bike', daily_rate: 29, serial_number: 'BIKE999')
    unused_addon = AddOn.create!(name: 'Carregador para Celular', daily_rate: 9, serial_number: 'CHARG567')

    rental = create(:rental, car_category: car_category)

    # Act
    login_as(user, scope: :user)
    visit start_rental_path(rental.id)
    select 'Fiat Mobi - Placa: ABC-1234 - Cor: Azul', from: 'Carro'
    check 'Carrinho de Bebê'
    check 'Transporte para Bike'
    click_on 'Confirmar'


    expect(current_path).to eq rental_path(rental.id)
    expect(page).to have_content 'Status Iniciada'
    expect(page).to have_content 'Carrinho de Bebê'
    expect(page).to have_content 'Transporte para Bike'
    expect(page).not_to have_content 'Carregador para Celular'
  end
end