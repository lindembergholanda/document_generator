FactoryBot.define do
  factory :subject do
    description { "Subject" } 

    trait :with_document_type do
      association :document_type, factory: [:document_type]
    end
  end
end
