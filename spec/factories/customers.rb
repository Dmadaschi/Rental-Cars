FactoryBot.define do
  factory :customer do
    sequence(:name) { |n| "Fulano #{n}" }
    sequence(:document) { CPF.generate }
    sequence(:email) { |n| "fulano#{n}@test.com.br" }
    sequence(:driver_license) { |n| "145254#{n}" }
    sequence(:phone) { |n| "(11)97514-453#{n}" }
    birth_date { '18/05/1994' }
  end
end
