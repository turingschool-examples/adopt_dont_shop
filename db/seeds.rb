require 'faker'

# shelters
5.times do 
  Shelter.create!(
    name: Faker::Address.community + " Pet Shelter",
    city: Faker::Address.city + ", AZ",
    foster_program: Faker::Boolean.boolean(true_ratio: 0.7),
    rank: Faker::Number.number(digits: 1)
  )
end

# pets
50.times do 
  Pet.create!(
    adoptable: Faker::Boolean.boolean(true_ratio: 0.7),
    age: Faker::Number.number(digits: 1),
    breed: Faker::Creature::Dog.breed,
    name: Faker::Creature::Dog.name,
    shelter_id: rand(1..5)
  )
end

# applications
10.times do
  Application.create!(
    human_name: Faker::Name.unique.name,
    street_address: Faker::Address.unique.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip,
    status: "In Progress"
  )
end

# applicationpets relationships
25.times do
  ApplicationPet.create!(
    application_id: rand(1..10),
    pet_id: rand(1..50)
  )
end