FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    breed  { Faker::Creature::Dog.breed }
    age { Faker::Creature::Dog.age }
  end
end
