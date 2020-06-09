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
    fill_in 'CNH', with: '456.544.45-2'
    fill_in 'Data de nascimento', with: '12/10/1974'
    fill_in 'Telefone', with: '(11)95481-2541'
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
    fill_in 'CNH', with: ''
    fill_in 'Data de nascimento', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('CNH não pode ficar em branco')
    expect(page).to have_content('Telefone não pode ficar em branco')
    expect(page).to have_content('Data de nascimento não pode ficar em branco')
    expect(page).to_not have_content('Cliente cadastrado com sucesso')
  end
end
