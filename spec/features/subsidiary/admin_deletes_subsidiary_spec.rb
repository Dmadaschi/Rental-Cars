require 'rails_helper'

feature 'Admin deletes manufacturer' do
  scenario 'successfully' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73',
                       address: 'endereço teste')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Sede'
    click_on 'Apagar filial'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and keep anothers' do
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
    click_on 'Apagar filial'

    expect(current_path).to eq subsidiaries_path
    expect(page).not_to have_content('Sede')
    expect(page).to have_content('Paulista')
  end
end
