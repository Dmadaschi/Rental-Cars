require 'rails_helper'

feature 'Admin register Subsisiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar nova filial', href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Sede'
    fill_in 'CNPJ', with: '1121312132133465465'
    fill_in 'Endereço', with: 'Av dos testes numero 100'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last.id)
    expect(page).to have_content('Sede')
    expect(page).to have_content('1121312132133465465')
    expect(page).to have_content('Av dos testes numero 100')
    expect(page).to have_link('Voltar')
  end
end
