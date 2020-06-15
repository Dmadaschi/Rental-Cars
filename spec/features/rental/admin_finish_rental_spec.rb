require 'rails_helper'

feature 'Admin finish rental' do
  scenario 'from code search' do
    user = create(:user)
    rental = create(:rental, status: 'ongoing')
    create(:car_rental, rental: rental)

    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Busca', with: rental.code
    click_on 'Pesquisar'

    expect(page).to have_content 'Finalizar'
  end

  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category, daily_rate: 50, car_insurance: 10,
                                         third_part_insurance: 15)
    fiat = create(:manufacturer, name: 'Fiat')
    mobi = create(:car_model, name: 'Mobi', manufacturer: fiat,
                              car_category: car_category)
    car = create(:car, car_model: mobi, license_plate: 'ABC-123', color: 'Azul')
    rental = create(:rental, car_category: car_category)

    travel_to Time.zone.local(2020, 05, 01, 13, 00, 00) do
      create(:car_rental, rental: rental, car: car, user: user,
                          daily_rate: car_category.daily_rate,
                          car_insurance: car_category.car_insurance,
                          third_part_insurance: car_category.third_part_insurance)
    end

    rental.ongoing!
    car.rented!

    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Busca', with: rental.code
    click_on 'Pesquisar'
    travel_to Time.zone.local(2020, 05, 05, 13, 00, 00) do
      click_on 'Finalizar'
    end

    rental.reload
    car.reload
    expect(page).to have_content 'Horário da Retirada: 01/05/2020 13:00:00'
    expect(page).to have_content 'Horário da Entrega: 05/05/2020 13:00:00'
    expect(page).to have_content 'Carro Retirado: Fiat Mobi - Placa: ABC-123 - Cor: Azul'
    expect(page).to have_content 'Valor total: R$ 225,00'
    expect(rental).to be_completed
    expect(car).to be_available
  end
end
