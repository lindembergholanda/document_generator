FactoryBot.define do
  factory :state do
    name { "Ceará" } 
    short_name { "CE" } 

    trait :with_country do
      association :country, factory: [:country]
    end
  end
end
