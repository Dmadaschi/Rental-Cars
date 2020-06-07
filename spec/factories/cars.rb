FactoryBot.define do
  factory :car do
    sequence(:license_plate) { |n| "ABC-123#{n}" }
    sequence(:mileage) { |n| n }
    color { 'Azul' }
    status { 'available' }
    car_model
  end
end
