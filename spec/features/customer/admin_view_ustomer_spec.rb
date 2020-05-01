require 'rails_helper'

feature 'Admin view customer' do
  scenario 'successfully' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    Customer.create!(name: 'José',
                     document: CPF.generate,
                     email: 'teste@teste.com.br')

    login_as(user, scope: :user)                     
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('José')
  end

  scenario 'with multiples customers' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    Customer.create!(name: 'José',
                     document: CPF.generate,
                     email: 'teste@teste.com.br')
    Customer.create!(name: 'João',
                     document: CPF.generate,
                     email: 'joão@teste.com.br')                     

    login_as(user, scope: :user)                     
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('José')
    expect(page).to have_content('João')
  end

  scenario 'with no customer' do
    user = User.create!(email:'teste@teste.com', password: '12345678')

    login_as(user, scope: :user)                     
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Nenhum cliente cadastrado')
  end

  scenario 'and view details' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    cpf = CPF.generate
    Customer.create!(name: 'José',
                     document: cpf,
                     email: 'teste@teste.com.br')

    login_as(user, scope: :user)                     
    visit root_path
    click_on 'Clientes'
    click_on 'José'
    
    expect(page).to have_content('José')
    expect(page).to have_content("CPF: " + cpf)
    expect(page).to have_content('Email: teste@teste.com.br')
  end
end
