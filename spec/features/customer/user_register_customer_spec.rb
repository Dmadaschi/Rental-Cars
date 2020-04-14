require 'rails_helper'

feature 'User register customers' do
  scenario 'successfully' do
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
  end
  
  scenario 'With already existant values' do
    Customer.create!(name: 'João',
                     document: '348.586.730-65', 
                     email: 'joao@teste.com.br')
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '348.586.730-65'
    fill_in 'Email', with: 'joao@teste.com.br'
    click_on 'Enviar'

    expect(page).not_to have_content('Nome já está em uso')
    expect(page).to have_content('CPF já está em uso')
    expect(page).to have_content('Email já está em uso')
  end

  scenario 'With blank values' do
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
  end

  scenario 'With invalid document' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '00000000000'
    fill_in 'Email', with: 'joao@teste.com.br'
    click_on 'Enviar'
    
    expect(page).to have_content('Digite um CPF valido')
  end
end
