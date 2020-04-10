require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73', 
                       address: 'endereço teste')
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Sede'
    fill_in 'CNPJ', with: '71.510.722/0001-34'
    fill_in 'Endereço', with: 'Av dos testes numero 100'
    click_on 'Enviar'
    
    expect(page).to have_content('Nome já está em uso')
  end

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

  scenario 'and address must be unique' do
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73', 
                       address: 'endereço teste')
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Paulista'
    fill_in 'CNPJ', with: '71.510.722/0001-34'
    fill_in 'Endereço', with: 'endereço teste'
    click_on 'Enviar'
    
    expect(page).to have_content('Endereço já está em uso')
  end

  scenario 'and name can not be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: '71.510.722/0001-34'
    fill_in 'Endereço', with: 'endereço teste'
    click_on 'Enviar'
    
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and cnpj can not be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Sede'
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: 'endereço teste'
    click_on 'Enviar'
    
    expect(page).to have_content('CNPJ não pode ficar em branco')
  end

  scenario 'and address can not be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Sede'
    fill_in 'CNPJ', with: '71.510.722/0001-34'
    fill_in 'Endereço', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'and cnpj can not be invalid' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Sede'
    fill_in 'CNPJ', with: '0000000000000'
    fill_in 'Endereço', with: 'endereço teste'
    click_on 'Enviar'
    
    expect(page).to have_content('Digite um CNPJ valido')
  end

end

