FactoryBot.define do
  factory :company_address do
    street_address { Faker::Address.street_name }
    number { Faker::Address.building_number }
    zip_code { Faker::Address.zip_code }

    trait :with_city do
      association :city, factory: [:city, :capital, :with_state]
    end

    trait :with_company do
      association :company, factory: [:company, :valid_cnpj]
    end
  end
end
