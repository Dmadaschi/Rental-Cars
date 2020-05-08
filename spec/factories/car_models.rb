FactoryBot.define do
  factory :car_model do
    sequence(:name)  { |n| "Modelo #{n}" }
    sequence(:year)  { |n| Date.today.year + n.year }
    sequence(:motorization) { |n| "#{n} CV" }
    fuel_type { "flex" }
    manufacturer
    car_category
  end
end