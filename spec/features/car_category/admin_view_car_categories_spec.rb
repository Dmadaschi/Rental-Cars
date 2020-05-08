require 'rails_helper'

feature 'Admin view car category' do
  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category)
    another_category = create(:car_category)

    login_as(user, scope: :user)                    
    visit root_path
    click_on 'Categorias de carro'

    expect(page).to have_content(car_category.name)
    expect(page).to have_content(another_category.name)
  end

  scenario 'and view details' do
    user = create(:user)
    car_category = create(:car_category, daily_rate: 50,
                          car_insurance: 20, third_part_insurance: 20)
    another_category = create(:car_category,daily_rate: 70,
                              car_insurance: 30, third_part_insurance: 30)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on car_category.name

    expect(page).to have_content("Categoria #{car_category.name}")
    expect(page).to have_content('Diária: R$ 50,00')
    expect(page).to have_content('Seguro: R$ 20,00')
    expect(page).to have_content('Seguro para terceiros: R$ 20,00')
    expect(page).not_to have_content("Categoria #{another_category.name}")
    expect(page).not_to have_content('Diária: R$ 70,00')
    expect(page).not_to have_content('Seguro: R$ 30,00')
    expect(page).not_to have_content('Seguro para terceiros: R$ 30,00')
  end

  scenario 'and no subsidiarys are created' do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'

    expect(page).to have_content('Nenhuma categoria de carro cadastrada')
  end

  scenario 'and return to home page' do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiarys page' do
    user = create(:user)
    create(:car_category, name: 'A')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'A'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
end
