FactoryBot.define do
  factory :subsidiary do
    sequence(:name)  { |n| "Filial #{n}" }
    cnpj { CNPJ.generate }
    sequence(:address) { |n| "AV Paulista numero #{n}"}
  end
end