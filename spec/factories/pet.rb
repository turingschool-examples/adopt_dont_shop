FactoryBot.define do
  factory :pet, class: Pet do
    association :shelter
    adoptable { true }
    age { Faker::Number.within(range: 1..22) }
    breed { Faker::Creature::Dog.breed }
    name { Faker::Creature::Dog.name }
  end
end
