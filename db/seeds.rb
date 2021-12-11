helping_hounds = Shelter.create!(name: 'Helping Hounds', city: 'Syracuse, NY', foster_program: false, rank: 2)

max = Pet.create!(name: 'Max', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: helping_hounds.id)

josie = Pet.create!(name: 'Josie', age: 5, breed: 'Great Pyrenees', adoptable: true, shelter_id: helping_hounds.id)

rambo = Pet.create!(name: 'Rambo', age: 1, breed: 'Chihuahua', adoptable: true, shelter_id: helping_hounds.id)

application1 = max.applications.create!(name: "John Doe", address: "123 Main Street", city: "Brooklyn", state: "NY", zip: "11205", reason: "I grew up with large dogs and want to bring the same joy into my home.", status: "in progress")

application1.pets << josie

application2 = josie.applications.create!(name: "Jeff Daniels", address: "456 Orderly Way", city: "Seattle", state: "WA", zip: "65412", reason: "I want to help as many innocent animals as I can.", status: "pending")
