require 'rails_helper'

feature 'Visitor view subsidiarys' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73', 
                       address: 'endereço teste')

    Subsidiary.create!(name: 'Paulista', 
                       cnpj: '49.751.431/0001-89',
                       address: 'Avenia Paulista')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Sede')
    expect(page).to have_content('Paulista')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73', 
                       address: 'endereço teste')

    Subsidiary.create!(name: 'Paulista', 
                       cnpj: '49.751.431/0001-89',
                       address: 'Avenia Paulista')

    visit root_path
    click_on 'Filiais'
    click_on 'Sede'

    expect(page).to have_content(
      'Sede - 01.290.370/0001-73 - endereço teste'
    )
    expect(page).not_to have_content(
      'Paulista - 49.751.431/0001-89 - Avenia Paulista'
    )
  end

  scenario 'and no subsidiarys are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiarys page' do
    Subsidiary.create!(name: 'Sede',
                       cnpj: '01.290.370/0001-73', 
                       address: 'endereço teste')

    Subsidiary.create!(name: 'Paulista', 
                       cnpj: '49.751.431/0001-89',
                       address: 'Avenia Paulista')

    visit root_path
    click_on 'Filiais'
    click_on 'Sede'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end
