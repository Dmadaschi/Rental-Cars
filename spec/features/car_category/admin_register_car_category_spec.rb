require 'rails_helper'

feature 'Admin register car categories' do
  scenario 'successfully' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome', with: 'A'
    fill_in 'Diária', with: '50'
    fill_in 'Seguro', with: '20'
    fill_in 'Seguro para terceiros', with: '20'
    click_on 'Enviar'

    expect(page).to have_content('Categoria A')
    expect(page).to have_content('Diária: R$ 50,00')
    expect(page).to have_content('Seguro: R$ 20,00')
    expect(page).to have_content('Seguro para terceiros: R$ 20,00')
    expect(page).to have_content('Categoria de carro cadastrada com sucesso')
  end
  
  scenario 'With already existant name' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    CarCategory.create!(name: 'A',
                        daily_rate: '50', 
                        car_insurance: '20',
                        third_part_insurance: '20')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome', with: 'A'
    fill_in 'Diária', with: '50'
    fill_in 'Seguro', with: '20'
    fill_in 'Seguro para terceiros', with: '20'
    click_on 'Enviar'
    
    expect(page).to have_content('Nome já está em uso')
    expect(page).to_not have_content('Categoria de carro cadastrada com sucesso')
  end

  scenario 'With blank values' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro', with: ''
    fill_in 'Seguro para terceiros', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Diária não pode ficar em branco')
    expect(page).to have_content('Seguro não pode ficar em branco')
    expect(page).to have_content('Seguro para terceiros não pode ficar em branco')
    expect(page).to_not have_content('Categoria de carro cadastrada com sucesso')
  end

  scenario 'With 0 values' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome', with: 'a'
    fill_in 'Diária', with: '0'
    fill_in 'Seguro', with: '0'
    fill_in 'Seguro para terceiros', with: '0'
    click_on 'Enviar'
    
    expect(page).to have_content('Diária deve ser maior que 0')
    expect(page).to have_content('Seguro deve ser maior que 0')
    expect(page).to have_content('Seguro para terceiros deve ser maior que 0')
    expect(page).to_not have_content('Categoria de carro cadastrada com sucesso')
  end
end
