require 'rails_helper'

feature 'Admin deletes subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    create(:subsidiary, name: 'Sede')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Sede'
    click_on 'Apagar filial'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and keep anothers' do
    user = create(:user)
    create(:subsidiary, name: 'Sede')
    create(:subsidiary, name: 'Paulista')

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
