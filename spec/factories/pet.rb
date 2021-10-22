FactoryBot.define do
  factory :pet, class: Pet do
    adoptable {Faker::Boolean.boolean}
    age {Faker::Number.between(from: 1, to: 15)}
    breed { Faker::Creature::Dog.breed }
    name { Faker::Creature::Animal.unique.name }
    association :shelter, factory: :shelter
  end
end
