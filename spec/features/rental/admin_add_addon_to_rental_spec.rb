require 'rails_helper'

feature 'Admin add addon to rental' do
  scenario 'view addons' do
    user = create(:user)

    create(:add_on, name: 'Carrinho de Bebê')
    create(:add_on, name: 'Transporte para Bike')

    rental = create(:rental)

    login_as(user, scope: :user)
    visit start_rental_path(rental.id)

    expect(page).to have_content 'Carrinho de Bebê'
    expect(page).to have_content 'Transporte para Bike'
  end

  scenario 'and choose addons' do
    user = create(:user)

    car_category = create(:car_category)
    fiat = create(:manufacturer, name: 'Fiat')
    mobi = create(:car_model, name: 'Mobi', manufacturer: fiat, car_category: car_category)
    create(:car, car_model: mobi, license_plate: 'ABC-1234', color: 'Azul')

    create(:add_on, name: 'Carrinho de Bebê')
    create(:add_on, name: 'Transporte para Bike')
    create(:add_on, name: 'Carregador para Celular')

    rental = create(:rental, car_category: car_category)

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