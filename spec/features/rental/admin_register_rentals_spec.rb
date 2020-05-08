require 'rails_helper'

feature 'Admin register rentals' do
  scenario 'successfully' do
    user = create(:user)
    customer = create(:customer)
    car_category = create(:car_category)

    login_as(user, scope: :user)                                       
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
    expect(page).to have_content('Locação realizada com sucesso')
  end

  scenario 'and must fill all fields' do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'
    click_on 'Registrar nova locação'
    click_on 'Enviar'

    expect(page).to have_content('Data de inicio não pode ficar em branco')
    expect(page).to have_content('Data final não pode ficar em branco')
    expect(page).to have_content('Cliente é obrigatório')
    expect(page).to have_content('Categoria de carro é obrigatório')
    expect(page).to_not have_content('Locação realizada com sucesso')
  end
end
