FactoryBot.define do
  factory :city do
    name { "Fortaleza" }

    trait :capital do
      capital { true }
    end

    trait :not_capital do
      capital { false }
    end

    trait :invalid_capital do
      capital { nil }
    end

    trait :with_state do
      association :state, factory: [:state, :with_country]
    end
  end
end
