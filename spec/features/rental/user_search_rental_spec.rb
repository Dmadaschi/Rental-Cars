require 'rails_helper'

feature 'User search_rental' do
  scenario 'seccessfully' do
    user = create(:user)
    rental = create(:rental)
    another_rental = create(:rental)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'
    fill_in 'Busca',	with: rental.code
    click_on 'Pesquisar'

    expect(page).to have_content(rental.code)
    expect(page).not_to have_content(another_rental.code)
  end

  scenario 'with invalid code' do
    user = create(:user)
    rental = create(:rental)
    another_rental = create(:rental)

    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Busca',	with: "12345678910"
    click_on 'Pesquisar'
    expect(page).to have_content("Nenhuma locação encontrada com este código")
    expect(page).to have_content(rental.code)
    expect(page).to have_content(another_rental.code)
  end
end
