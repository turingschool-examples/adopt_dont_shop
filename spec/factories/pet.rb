FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    breed {Faker::Creature::Dog.breed }
    age { Faker::Number.between(from: 1, to: 15) }
    adoptable { true }
    shelter_id { Faker::Number.between(from: 1, to: 15) }
  end
end
