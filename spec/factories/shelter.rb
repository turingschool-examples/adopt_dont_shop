FactoryBot.define do
  factory :shelter, class: Shelter do
    foster_program { true }
    age { Faker::Number.within(range: 1..22) }
    name { (Faker::Address.city) + (" Shelter")  }
    city { Faker::Address.city }
    rank { Faker::Number.within(range: 1..5) }
  end
end
