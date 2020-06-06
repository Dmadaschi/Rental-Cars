require 'rails_helper'

feature 'Admin register cars' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer, name: 'Fiat')
    create(:car_model, name: 'Uno', manufacturer: manufacturer,
                       motorization: '1.6', year: '2019', fuel_type: 'Flex')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Veiculos'
    click_on 'Registrar novo veiculo para frota'

    select 'Fiat Uno - 2019 - 1.6 - Flex', from: 'Modelo'
    fill_in 'Placa', with: 'ASF-123'
    fill_in 'Milhagem', with: '1500'
    fill_in 'Cor', with: 'Azul'
    click_on 'Enviar'

    expect(page).to have_content('Fiat Uno - 2019 - 1.6 - Flex')
    expect(page).to have_content('ASF-123')
    expect(page).to have_content('1500 km')
    expect(page).to have_content('Azul')
    #expect(page).to have_content('Disponivel')
    expect(page).to have_content('Carro cadastrado com sucesso')
  end

  scenario 'with blank values' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Veiculos'
    click_on 'Registrar novo veiculo para frota'
    click_on 'Enviar'

    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Milhagem não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to_not have_content('Carro cadastrado com sucesso')
  end
end
