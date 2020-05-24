require 'rails_helper'

feature 'Admin register Subsisiary' do
  scenario 'from index page' do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar nova filial',
                              href: new_subsidiary_path)
  end

  scenario 'successfully' do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Sede'
    fill_in 'CNPJ', with: '71.510.722/0001-34'
    fill_in 'Endereço', with: 'Av dos testes numero 100'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    expect(page).to have_content('Filial cadastrada com sucesso')
    expect(page).to have_content('Sede')
    expect(page).to have_content('71.510.722/0001-34')
    expect(page).to have_content('Av dos testes numero 100')
    expect(page).to have_link('Voltar')
  end

  scenario 'and name must be unique' do
    user = create(:user)
    create(:subsidiary, name: 'Sede')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Sede'
    fill_in 'CNPJ', with: '01.290.370/0001-73'
    fill_in 'Endereço', with: 'Av dos testes numero 100'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
end
