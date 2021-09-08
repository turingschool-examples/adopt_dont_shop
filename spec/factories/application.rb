FactoryBot.define do
  factory :shelter, class: Shelter do
    name { Faker::Company.unique.name  }
    city  { Faker::Address.city }
    foster_program { Faker::Boolean.boolean(true_ratio: 0.5) }
    rank { Faker::Number.within(range: 1..99) }
  end
end
