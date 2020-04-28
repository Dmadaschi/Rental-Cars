require 'rails_helper'

feature 'Admin view car category' do
  scenario 'successfully' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    CarCategory.create!(name: 'A',
                        daily_rate: '50', 
                        car_insurance: '20',
                        third_part_insurance: '20')
    CarCategory.create!(name: 'B',
                        daily_rate: '70', 
                        car_insurance: '30',
                        third_part_insurance: '30')

    login_as(user, scope: :user)                    
    visit root_path
    click_on 'Categorias de carro'

    expect(page).to have_content('A')
    expect(page).to have_content('B')
  end

  scenario 'and view details' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    CarCategory.create!(name: 'A',
                        daily_rate: '50', 
                        car_insurance: '20',
                        third_part_insurance: '20')
    CarCategory.create!(name: 'B',
                        daily_rate: '70', 
                        car_insurance: '30',
                        third_part_insurance: '30')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'A'

    expect(page).to have_content('Categoria A')
    expect(page).to have_content('Diária: R$ 50,00')
    expect(page).to have_content('Seguro: R$ 20,00')
    expect(page).to have_content('Seguro para terceiros: R$ 20,00')
    expect(page).not_to have_content('Categoria B')
    expect(page).not_to have_content('Diária: R$ 70,00')
    expect(page).not_to have_content('Seguro: R$ 30,00')
    expect(page).not_to have_content('Seguro para terceiros: R$ 30,00')
  end

  scenario 'and no subsidiarys are created' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'

    expect(page).to have_content('Nenhuma categoria de carro cadastrada')
  end

  scenario 'and return to home page' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiarys page' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    CarCategory.create!(name: 'A',
                        daily_rate: '50', 
                        car_insurance: '20',
                        third_part_insurance: '20')
    CarCategory.create!(name: 'B',
                        daily_rate: '70', 
                        car_insurance: '30',
                        third_part_insurance: '30')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'A'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
end
