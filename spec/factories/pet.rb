FactoryBot.define do
  factory :pet, class: Pet do
    # association :pet_shelter, factory: :pet_shelter
    adoptable { Faker::Boolean.boolean }
    age { Faker::Number.between(from: 1, to: 20) }
    breed { Faker::Creature::Cat.breed }
    name { Faker::TvShows::SouthPark.unique.character }
  end
end
