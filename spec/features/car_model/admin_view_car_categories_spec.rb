require 'rails_helper'

feature 'Admin view car model' do
  scenario 'successfully' do
    user = create(:user)
    fiat = create(:manufacturer, name: 'Fiat')
    hatch = create(:car_category, name: 'Hatch')
    create(:car_model, name: 'Uno', year: '2019',
           motorization: '32',fuel_type: 'flex',
           manufacturer: fiat, car_category: hatch)

    login_as(user, scope: :user)                     
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
    user = create(:user)
    
    car_model= create(:car_model)
    another_car_model= create(:car_model)
                     
    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content(car_model.name)
    expect(page).to have_content(car_model.year)
    expect(page).to have_content(car_model.motorization)
    expect(page).to have_content(car_model.fuel_type)
    expect(page).to have_content(car_model.car_category.name)
    expect(page).to have_content(car_model.manufacturer.name)
    expect(page).to have_content(another_car_model.name)
    expect(page).to have_content(another_car_model.year)
    expect(page).to have_content(another_car_model.motorization)
    expect(page).to have_content(another_car_model.fuel_type)
    expect(page).to have_content(another_car_model.car_category.name)
    expect(page).to have_content(another_car_model.manufacturer.name)
  end

  scenario 'with no car model' do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end

  scenario 'and redirtect to manufacturer' do
    user = create(:user)
    fiat = create(:manufacturer, name: 'Fiat')
    hatch = create(:car_category, name: 'Hatch')
    create(:car_model, name: 'Uno', manufacturer: fiat,
           car_category: hatch)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).not_to have_content('Uno')
    expect(page).not_to have_content('Hatch')
  end

  scenario 'and return to home' do
    user = create(:user)
    create(:car_model)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

end
