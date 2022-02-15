Shelter.destroy_all
Pet.destroy_all

shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
pet_1 = Pet.create!(name: "Pork Chop", age: 6, breed: "Poodle", adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: "Tiny", age: 4, breed: "Great Dane", adoptable: true, shelter_id: shelter_1.id)
pet_3 = Pet.create!(name: "Richard", age: 5, breed: "Maine Coone", adoptable: true, shelter_id: shelter_1.id)
pet_4 = Pet.create!(name: "Gertrude", age: 2, breed: "Corgi", adoptable: true, shelter_id: shelter_2.id)
pet_5 = Pet.create!(name: "Edna", age: 7, breed: "Cat", adoptable: true, shelter_id: shelter_2.id)
pet_3 = Pet.create!(name: "Clarence", age: 1, breed: "Maltipoo", adoptable: true, shelter_id: shelter_3.id)
application_1 = Application.create!(name: "Britney Spears", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "Pending")
application_2 = Application.create!(name: "Justin Timberlake", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "Pending")
application_3 = Application.create!(name: "Lil Kim", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "Pending")
application_4 = Application.create!(name: "Snoop Dogg", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "In Progress")
application_5 = Application.create!(name: "Eminem", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "In Progress")
