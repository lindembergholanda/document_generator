FactoryBot.define do
  factory :company_contact do
    personal_title { Faker::Name.prefix }
    name { Faker::Name.name }
    occupation { Faker::Job.position }
    sector { Faker::Job.field }

    trait :send_document do
      send_document { true }
    end

    trait :not_send_document do
      send_document { false }
    end

    trait :invalid_send_document do
      send_document { nil }
    end

    trait :with_company do
      association :company, factory: [:company, :valid_cnpj]
    end
  end
end
