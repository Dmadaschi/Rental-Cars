require 'rails_helper'

feature 'User log in' do
  scenario 'successfully' do
    User.create!(email: 'teste@teste.com', password: '123456')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(page).to have_content('login efetuado com sucesso')
    expect(page).to have_link('Fabricantes')
    expect(page).to have_link('Filiais')
    expect(page).to have_link('Categorias de carro')
    expect(page).to have_link('Clientes')
    expect(page).to have_link('Locação')
    expect(page).to have_link('Modelos de carro')
  end
end