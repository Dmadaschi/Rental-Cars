require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'from index page' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_link('Registrar novo fabricante', href: new_manufacturer_path)
  end

  scenario 'successfully' do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(current_path).to eq manufacturer_path(Manufacturer.last.id)
    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
    expect(page).to have_content('Fabricante cadastrado com sucesso')
  end
end
