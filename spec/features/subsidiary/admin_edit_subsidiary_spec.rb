require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    user = create(:user)
    create(:subsidiary, name: 'Sede')

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

  scenario 'with invalid data' do
    user = create(:user)
    create(:subsidiary, name: 'Sede')

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
end
