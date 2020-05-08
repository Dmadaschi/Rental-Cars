require 'rails_helper'

feature 'Admin view rentals' do
  scenario 'successfully' do
    user = create(:user)
    customer = create(:customer, name: 'João', document: '348.586.730-65')
    car_category = create(:car_category, name: 'Hatch')
    create(:rental, start_date: '16/04/2030', end_date: '18/04/2030',
           customer: customer, car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'

    expect(page).to have_content('16/04/2030')
    expect(page).to have_content('18/04/2030')
    expect(page).to have_content('João - 348.586.730-65')
    expect(page).to have_content('Hatch')
  end
  scenario 'and no manufacturers are created' do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'

    expect(page).to have_content('Nenhuma locação cadastrado')
  end
  scenario 'with multiples rentals' do
    user = create(:user)
    rental = create(:rental, start_date: '16/04/2030', end_date: '18/04/2030')
    another_rental = create(:rental, start_date: '12/05/2030',
                            end_date: '22/06/2030')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'

    expect(page).to have_content('16/04/2030')
    expect(page).to have_content('18/04/2030')
    expect(page).to have_content('12/05/2030')
    expect(page).to have_content('22/06/2030')
    expect(page).to have_content(rental.customer.identification )
    expect(page).to have_content(another_rental.customer.identification)
    expect(page).to have_content(rental.car_category.name)
    expect(page).to have_content(another_rental.car_category.name)
  end
  scenario 'and redirect to customer' do
    user = create(:user)
    customer = create(:customer)
    create(:rental, customer: customer)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'
    click_on customer.name

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content(customer.email)
  end
  scenario 'and redirect to car_category' do
    user = create(:user)
    car_category = create(:car_category, daily_rate: '50', 
                          car_insurance: '20', third_part_insurance: '20')
    create(:rental, car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'
    click_on car_category.name

    expect(page).to have_content(car_category.name)
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('R$ 20,00')
  end
end
