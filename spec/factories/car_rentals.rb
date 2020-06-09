FactoryBot.define do
  factory :car_rental do
    sequence(:daily_rate)  { |n| 20 + n }
    sequence(:car_insurance) { |n| 25 + n }
    sequence(:third_part_insurance) { |n| 30 + n }
    rental
    car
    user
  end
end
