FactoryBot.define do
  factory :car do
    sequence(:license_plate)  { |n| "ABC-123#{n}" }
    sequence(:mileage)  { |n| n }
    color { 'Azul' }
    car_model
  end
end