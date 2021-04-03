FactoryBot.define do
  factory :pet, class: Pet do
    adoptable { Faker::Boolean.boolean }
    age { Faker::Number.between(from: 1, to: 20) }
    breed { Faker::Creature::Cat.breed }
    name { Faker::TvShows::SouthPark.unique.character }

    association :shelter, factory: :shelter
  end
end
