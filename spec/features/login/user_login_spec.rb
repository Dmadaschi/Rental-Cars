require 'rails_helper'

feature 'User log in' do
  scenario 'successfully' do
    User.create!(email: 'teste@teste.com', password: '123456')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link('Fabricantes')
    expect(page).to have_link('Filiais')
    expect(page).to have_link('Categorias de carro')
    expect(page).to have_link('Clientes')
    expect(page).to have_link('Locação')
    expect(page).to have_link('Modelos de carro')
    expect(page).to have_link('Log out')
    expect(page).not_to have_link('Entrar')
  end
  scenario 'and log out' do
    User.create!(email: 'teste@teste.com', password: '123456')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'
    click_on 'Log out'

    expect(page).to have_content('Saiu com sucesso')
    expect(page).to_not have_content('Login efetuado com sucesso')
    expect(page).to_not have_link('Fabricantes')
    expect(page).to_not have_link('Filiais')
    expect(page).to_not have_link('Categorias de carro')
    expect(page).to_not have_link('Clientes')
    expect(page).to_not have_link('Locação')
    expect(page).to_not have_link('Modelos de carro')
    expect(page).to_not have_link('Log out')
    expect(page).to have_link('Entrar')
  end
end