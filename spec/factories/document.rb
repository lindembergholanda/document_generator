FactoryBot.define do
  factory :document do
    date { Faker::Date.forward(1) }

    trait :with_subject do
      association :subject, factory: [:subject, :with_document_type]
    end

    trait :with_company_contact do
      association :company_contact, factory: [:company_contact, :send_document, :with_company]
    end

    trait :with_responsible do
      association :responsible, factory: [:company_contact, :send_document, :with_company]
    end
  end
end
