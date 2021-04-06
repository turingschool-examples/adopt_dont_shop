denver_animal_shelter = Shelter.create!(name: "Denver Animal Shelter", city: "Denver", rank: 1, foster_program: true)

baxter = Pet.create!(name: "baxter", breed: "bulldog", age: 7, adoptable: true)
ace = Pet.create!(name: "ace", breed: "siamese", age: 3, adoptable: true)
bella = Pet.create!(name: "bella", breed: "poodle", age: 2, adoptable: true)
fallon = Pet.create!(name: "fallon", breed: "bengal", age: 8, adoptable: true)

application1 = Application.create!(name: "application1", street: "82 baker st", city: "Denver", state: "CO", zip: 80123, description: "plenty of time for care", status: "in progress")
application2 = Application.create!(name: "application2", street: "1327 beedle dr", city: "Austin", state: "TX", zip: 78613, description: "big backyard to run around", status: "pending")
