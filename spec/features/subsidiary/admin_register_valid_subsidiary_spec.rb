require 'rails_helper'

feature 'Admin register valid subsidiary' do

  scenario 'and cnpj must be unique' do
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73', 
                       address: 'endereço teste')
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '01.290.370/0001-73'
    fill_in 'Endereço', with: 'Av dos testes numero 100'
    click_on 'Enviar'
    
    expect(page).to have_content('CNPJ já está em uso')
  end

  scenario 'and fields can not be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'and name and cnpj must be unique' do
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73', 
                       address: 'endereço teste')
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Sede'
    fill_in 'CNPJ', with: '01.290.370/0001-73'
    fill_in 'Endereço', with: 'Av dos testes numero 100'
    click_on 'Enviar'
    
    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('CNPJ já está em uso')
  end
end

