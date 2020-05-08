FactoryBot.define do
  factory :customer do
    sequence(:name)  { |n| "Fulano #{n}" }
    sequence(:document) { CPF.generate }
    sequence(:email)  { |n| "fulano#{n}@test.com.br" }
  end
end