Shelter.destroy_all
Pet.destroy_all

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
pet_1 = Pet.create!(name: "Pork Chop", age: 6, breed: "Poodle", adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: "Tiny", age: 4, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
pet_3 = Pet.create!(name: "Richard", age: 5, breed: "Maine Coone", adoptable: true, shelter_id: shelter_1.id)
