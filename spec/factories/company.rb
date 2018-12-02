FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    trade_name { Faker::Company.suffix }

    trait :valid_cnpj do
      cnpj { "41.249.349/0001-49" }
    end

    trait :invalid_cnpj do
      cnpj { "00.000.000/0000-00" }
    end
  end
end
