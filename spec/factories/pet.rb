FactoryBot.define do
  factory :pet do
    adoptable {Faker::Boolean.adoptable}
    age {Faker::Number.age}
    breed {Faker::Name.breed}
    name {Faker::Name.name}
    shelter_id {Faker::Number.shelter_id}
  end
end
