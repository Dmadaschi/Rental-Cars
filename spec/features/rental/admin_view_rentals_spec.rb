require 'rails_helper'

feature 'Admin view rentals' do
  scenario 'successfully' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    customer = Customer.create!(name: 'João',
                                document: '348.586.730-65', 
                                email: 'joao@teste.com.br')
    car_category = CarCategory.create!(name: 'Hatch',
                                       daily_rate: '50', 
                                       car_insurance: '20',
                                       third_part_insurance: '20')
    Rental.create!(start_date: '16/04/2030',
                   end_date: '18/04/2030',
                   customer: customer,
                   car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'

    expect(page).to have_content('16/04/2030')
    expect(page).to have_content('18/04/2030')
    expect(page).to have_content('João - 348.586.730-65')
    expect(page).to have_content('Hatch')
  end
  scenario 'and no manufacturers are created' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'

    expect(page).to have_content('Nenhuma locação cadastrado')
  end
  scenario 'with multiples rentals' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    customer = Customer.create!(name: 'João',
                                document: '348.586.730-65', 
                                email: 'joao@teste.com.br')
    car_category = CarCategory.create!(name: 'Hatch',
                                       daily_rate: '50', 
                                       car_insurance: '20',
                                       third_part_insurance: '20')
    Rental.create!(start_date: '16/04/2030',
                   end_date: '18/04/2030',
                   customer: customer,
                   car_category: car_category)

    another_customer = Customer.create!(name: 'Maria',
                                        document: '052.694.920-16', 
                                        email: 'maria@teste.com.br')
    another_car_category = CarCategory.create!(name: 'Sedan',
                                               daily_rate: '100', 
                                               car_insurance: '30',
                                               third_part_insurance: '30')
    Rental.create!(start_date: '12/05/2030',
                   end_date: '22/06/2030',
                   customer: another_customer,
                   car_category: another_car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'

    expect(page).to have_content('16/04/2030')
    expect(page).to have_content('18/04/2030')
    expect(page).to have_content('12/05/2030')
    expect(page).to have_content('22/06/2030')
    expect(page).to have_content(customer.identification )
    expect(page).to have_content(another_customer.identification)
    expect(page).to have_content(car_category.name)
    expect(page).to have_content(another_car_category.name)
  end
  scenario 'and redirect to customer' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    customer = Customer.create!(name: 'João',
                                document: '348.586.730-65', 
                                email: 'joao@teste.com.br')
    car_category = CarCategory.create!(name: 'Hatch',
                                       daily_rate: '50', 
                                       car_insurance: '20',
                                       third_part_insurance: '20')
    Rental.create!(start_date: '16/04/2030',
                   end_date: '18/04/2030',
                   customer: customer,
                   car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locação'
    click_on customer.name

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content(customer.email)
  end
  scenario 'and redirect to car_category' do
    user = User.create!(email:'teste@teste.com', password: '12345678')
    customer = Customer.create!(name: 'João',
                                document: '348.586.730-65', 
                                email: 'joao@teste.com.br')
    car_category = CarCategory.create!(name: 'Hatch',
                                       daily_rate: '50', 
                                       car_insurance: '20',
                                       third_part_insurance: '20')
    Rental.create!(start_date: '16/04/2030',
                   end_date: '18/04/2030',
                   customer: customer,
                   car_category: car_category)

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
