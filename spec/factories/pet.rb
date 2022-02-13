FactoryBot.define do
  factory :pet do
    shelter

    adoptable       { true }
    age             { Faker::Number.number(digits: 2) }
    breed           { Faker::Creature::Dog.breed }
    name            { Faker::Creature::Dog.name }
  end
end
