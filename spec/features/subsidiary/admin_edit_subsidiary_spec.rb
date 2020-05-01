require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73',
                       address: 'endereço teste')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Sede'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '71.510.722/0001-34'
    fill_in 'Endereço', with: 'Av dos testes numero 100'
    click_on 'Enviar'

    expect(page).to have_content('Filial atualizada com sucesso')
    expect(page).to have_content('Paulista')
    expect(page).to have_content('71.510.722/0001-34')
    expect(page).to have_content('Av dos testes numero 100')
    expect(Subsidiary.count).to eq(1)
  end

  scenario 'with blank data' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73',
                       address: 'endereço teste')

    login_as(user, scope: :user)                       
    visit root_path
    click_on 'Filiais'
    click_on 'Sede'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'with invalid data' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73',
                       address: 'endereço teste')
    Subsidiary.create!(name: 'Paulista', 
                       cnpj: '49.751.431/0001-89',
                       address: 'Avenia Paulista')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Sede'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '49.751.431/0001-89'
    fill_in 'Endereço', with: 'Avenia Paulista'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('CNPJ já está em uso')
  end

  scenario 'with invalid data' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73',
                       address: 'endereço teste')

    login_as(user, scope: :user)                       
    visit root_path
    click_on 'Filiais'
    click_on 'Sede'
    click_on 'Editar'
    fill_in 'CNPJ', with: '000000000'
    click_on 'Enviar'

    expect(page).to have_content('Digite um CNPJ valido')
  end
end
