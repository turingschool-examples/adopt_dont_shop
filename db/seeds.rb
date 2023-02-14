# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter = Shelter.create!(foster_program: true, name: "Boulder Humane Society", city: "Boulder", rank: 1)

application_1 = Application.create!({
    name: "Adam",
    street_address: "123 Road",
    city: "Avon",
    state: "Colorado",
    zip_code: "81620",
    description: "Looking for a good boy"
  }
)

application_2 = Application.create!({
    name: "Brian",
    street_address: "321 Lane",
    city: "Boulder",
    state: "Colorado",
    zip_code: "80310",
    description: "Big yard to play in"
  }
)

application_3 = Application.create!({
    name: "John",
    street_address: "152 Doe Rd",
    city: "Denver",
    state: "Colorado",
    zip_code: "81233",
    description: "Have cats"
  }
)


application_4 = Application.create!({
  name: "John",
  street_address: "152 Doe Rd",
  city: "Denver",
  state: "Colorado",
  zip_code: "81233",
  description: "Have cats"
}
)

pet_1 = Pet.create!({
    adoptable: true,
    age: 2,
    breed: "ACD",
    name: "Jax",
    shelter: shelter
  }
)

pet_2 = Pet.create!({
    adoptable: true,
    age: 3,
    breed: "Yorkie",
    name: "Butkus",
    shelter: shelter
  }
)

pet_3 = Pet.create!({
    adoptable: true,
    age: 5,
    breed: "Doodle",
    name: "Bear",
    shelter: shelter
  }
)

pet_4 = Pet.create!({
    adoptable: true,
    age: 1,
    breed: "Lab",
    name: "Rylo",
    shelter: shelter
  }
)

pet_application_1 = PetApplication.create!({
    pet: pet_1,
    application: application_1
  }
)

pet_application_2 = PetApplication.create!({
    pet: pet_2,
    application: application_1
  }
)

pet_application_3 = PetApplication.create!({
    pet: pet_2,
    application: application_2
  }
)

pet_application_4 = PetApplication.create!({
    pet: pet_3,
    application: application_2
  }
)

pet_application_5 = PetApplication.create!({
    pet: pet_3,
    application: application_3
  }
)

pet_application_6 = PetApplication.create!({
    pet: pet_4,
    application: application_3
  }
)