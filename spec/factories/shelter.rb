FactoryBot.define do
  factory :shelter do
    name { Faker::Company.name }
    city { Faker::Address.city }
    rank { Faker::Number.between(from: 1, to: 15) }
    foster_program { Faker::Boolean.boolean }
  end
end
