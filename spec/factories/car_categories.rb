FactoryBot.define do
  factory :car_category do
    sequence(:name)  { |n| "Categoria #{n}" }
    sequence(:daily_rate) { |n| ( n + 10 ) }
    sequence(:car_insurance) { |n| ( n + 15 ) }
    sequence(:third_part_insurance) { |n| ( n + 20 ) }
  end
end
