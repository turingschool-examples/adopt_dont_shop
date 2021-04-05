FactoryBot.define do
  factory :pet, class: Pet do
    adoptable {[true,false].sample}
    age {Faker::Number.between(from: 1, to: 10)}
    breed {Faker::Fantasy::Tolkien.race}
    name { Faker::Games::Pokemon.name }
    association :shelter, factory: :shelter
  end
end
