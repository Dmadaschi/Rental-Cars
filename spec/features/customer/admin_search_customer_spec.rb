require 'rails_helper'

feature 'User search_customer' do
  scenario 'seccessfully with name' do
    user = create(:user)
    customer = create(:customer)
    another_customer = create(:customer)                              

    login_as(user, scope: :user)
    visit customers_path
    fill_in 'Busca',	with: customer.name
    click_on 'Pesquisar'
    
    expect(page).to have_content("Resultado da busca por: #{customer.name}")
    expect(page).to have_content(customer.name)
    expect(page).not_to have_content(another_customer.name)
  end

  scenario 'seccessfully with cpf' do
    user = create(:user)
    customer = create(:customer)
    another_customer = create(:customer)                                

    login_as(user, scope: :user)
    visit customers_path
    fill_in 'Busca',	with: customer.document
    click_on 'Pesquisar'

    expect(page).to have_content("Resultado da busca por: #{customer.document}")
    expect(page).to have_content(customer.name)
    expect(page).not_to have_content(another_customer.name)
  end

  scenario 'with invalid name' do
    user = create(:user)
    customer = create(:customer, name: 'João')
    another_customer = create(:customer, name: 'Jorge')                         

    login_as(user, scope: :user)
    visit customers_path
    fill_in 'Busca',	with: 'Mateus'
    click_on 'Pesquisar'
    
    expect(page).to have_content("Resultado da busca por: Mateus")
    expect(page).to have_content('Nenhum cliente cadastrado')
    expect(page).not_to have_content(customer.name)
    expect(page).not_to have_content(another_customer.name)
  end

  scenario 'with invalid cpf' do
    user = create(:user)
    customer = create(:customer)
    another_customer = create(:customer)                                

    login_as(user, scope: :user)
    visit customers_path
    fill_in 'Busca',	with: '12132131232'
    click_on 'Pesquisar'

    expect(page).to have_content("Resultado da busca por: 12132131232")
    expect(page).to have_content('Nenhum cliente cadastrado')
    expect(page).not_to have_content(customer.name)
    expect(page).not_to have_content(another_customer.name)
  end

  scenario 'with multiple recors' do
    user = create(:user)
    customer = create(:customer, name: 'Jõao')
    another_customer = create(:customer, name: 'Jorge')                                

    login_as(user, scope: :user)
    visit customers_path
    fill_in 'Busca',	with: 'J'
    click_on 'Pesquisar'

    expect(page).to have_content("Resultado da busca por: J")
    expect(page).to have_content(customer.name)
    expect(page).to have_content(another_customer.name)
  end
end
