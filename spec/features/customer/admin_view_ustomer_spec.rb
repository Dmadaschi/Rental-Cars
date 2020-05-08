require 'rails_helper'

feature 'Admin view customer' do
  scenario 'successfully' do
    user = create(:user)
    create(:customer, name: 'José')

    login_as(user, scope: :user)                     
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('José')
  end

  scenario 'with multiples customers' do
    user = create(:user)
    create(:customer, name: 'José')
    create(:customer, name: 'João')                    

    login_as(user, scope: :user)                     
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('José')
    expect(page).to have_content('João')
  end

  scenario 'with no customer' do
    user = create(:user)

    login_as(user, scope: :user)                     
    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Nenhum cliente cadastrado')
  end

  scenario 'and view details' do
    user = create(:user)
    cpf = CPF.generate
    create(:customer, name: 'José', document: cpf,
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
