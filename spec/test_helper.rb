def seed_shelters
  @shelter_1 = Shelter.create!(
    foster_program: true,
    name: "Healthy Paws",
    city: "Denver",
    rank: 3
  )

  @shelter_2 = Shelter.create!(
    foster_program: true,
    name: "Ruff Day",
    city: "Detroit",
    rank: 2
  )

  @shelter_3 = Shelter.create!(
    foster_program: true,
    name: "AAA Shelter",
    city: "Houston",
    rank: 1
  )
end

def seed_applications
  @application_1 = Application.create!(
    name: "Bob",
    street_address: "123 Leaf Street",
    city: "Denver",
    state: "CO",
    zip_code: 80020,
    description: "Work from home",
    status: "In Progress"
  )
end

def seed_pets
  @pet_1 = @application_1.pets.create!(
    name: "Pepper",
    adoptable: true,
    age: 4,
    breed: "Pitbull",
    shelter_id: @shelter_1.id
  )
    
  @pet_2 = @application_1.pets.create!(
    name: "Daisy",
    adoptable: true,
    age: 14,
    breed: "Beagle",
    shelter_id: @shelter_1.id
  )
end