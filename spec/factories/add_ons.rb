FactoryBot.define do
  factory :add_on do
    sequence(:name) { |n| "#{n}MyString" }
    sequence(:daily_rate) { |n| "1.#{n}" }
    sequence(:serial_number) { |n| "MyString#{n}" }
  end
end
