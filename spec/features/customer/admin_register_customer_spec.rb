require 'rails_helper'

feature 'User register customers' do
  scenario 'successfully' do
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '348.586.730-65'
    fill_in 'Email', with: 'joao@teste.com.br'
    click_on 'Enviar'

    expect(page).to have_content('João')
    expect(page).to have_content('CPF: 348.586.730-65')
    expect(page).to have_content('Email: joao@teste.com.br')
    expect(page).to have_content('Cliente cadastrado com sucesso')

  end

  scenario 'With blank values' do
    user = create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to_not have_content('Cliente cadastrado com sucesso')
  end
end
