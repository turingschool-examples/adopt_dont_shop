FactoryBot.define do
  factory :pet, class: Pet do
    name { Faker::Creature::Dog.unique.name }
    age  { Faker::Number.within(range: 1..24) }
    adoptable { Faker::Boolean.boolean(true_ratio: 0.8) }
    breed { Faker::Creature::Dog.breed }
  end
end
