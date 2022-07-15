
mystery = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
aurora = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
hollywood = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
rgv = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)


lucille = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: mystery.id)
lobster = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)
beethoven = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: hollywood.id) 
barey = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: rgv.id)
charlie = Pet.create(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: mystery.id)


best_vets = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
bird_vets = VeterinaryOffice.create(name: 'Put a bird on it', boarding_services: true, max_patient_capacity: 5)
healers_vets = VeterinaryOffice.create(name: 'Pet Healers', boarding_services: false, max_patient_capacity: 10)
country_vets = VeterinaryOffice.create(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)


taylor = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: best_vets.id)
jim = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: bird_vets.id)
kelsey = Veterinarian.create(name: 'Kelsey', on_call: true, review_rating: 9, veterinary_office_id: healers_vets.id)
sarah = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: false, veterinary_office_id: country_vets.id)
sam = Veterinarian.create(name: 'Sam', review_rating: 10, on_call: false, veterinary_office_id: best_vets.id)


application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
application_2 = Application.create!(name: "Cindy Smith", street: "727 Lane road", city: "Rockville", state: "CA", zipcode: 95148, status:"In Progress", description:"I have a big yard them to run all day")
application_3 = Application.create!(name: "Ryan Scott", street: "21 Longwalk street", city: "Denver", state: "CO", zipcode: 34687, status:"In Progress", description:"I have lots of time to play fetch")
application_4 = Application.create!(name: "Jean Frisco", street: "546 Uphill Road", city: "Springs", state: "TX", zipcode: 57465, status:"In Progress", description:"I will give them all of the pets I can")

