# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

FactoryBot.define do
  factory :shelter do
    foster_program { rand(2) == 0 }
    name { Faker::Address.street_address }
    city { Faker::Address.city}
    rank { rand(1..5) }
  end

  factory :pet do
    adoptable { rand(2) == 0 }
    age { rand(1..15) }
    breed { Faker::Creature::Dog.breed }
    name { Faker::Creature::Dog.name }
  end

  factory :veterinary_office do
    boarding_services { rand(2) == 0 }
    max_patient_capacity { rand(10..50) }
    name { Faker::Company.name }
  end

  factory :veterinarian do
    on_call { rand(2) == 0 }
    review_rating { rand(1..5) }
    name { Faker::Name.name}
  end

end

10.times do
  shelter = Shelter.create!(FactoryBot::attributes_for(:shelter))
  rand(5..10).times do
    attrs = FactoryBot::attributes_for(:pet)
    shelter.pets.create!(attrs)
  end
end

10.times do
  veterinary_office = VeterinaryOffice.create!(FactoryBot::attributes_for(:veterinary_office))
  rand(2..3).times do
    attrs = FactoryBot::attributes_for(:veterinarian)
    veterinary_office.veterinarians.create!(attrs)
  end
end
