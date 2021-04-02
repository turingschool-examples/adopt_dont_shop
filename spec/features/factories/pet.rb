FactoryBot.define do
  factory :pet do
    shelter
    name {Faker::Creature::Dog.name}
    breed {Faker::Creature::Dog.breed}
    age {rand(0..15)}
    adoptable {Faker::Boolean.boolean}
  end
end
