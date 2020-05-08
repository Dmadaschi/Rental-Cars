FactoryBot.define do
  factory :rental do
    sequence(:start_date)  { |n| Date.today + n.day }
    sequence(:end_date)  { |n| Date.today + (1 + n).day }
    customer
    car_category
  end
end