Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

#Mystery Shelter and pets
mystery = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
scooby = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: mystery.id)
scrappy = Pet.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: mystery.id)

#Heavenly shelter and pets
heavenly = Shelter.create(name: 'Heavenly pets', city: 'Aurora, CO', foster_program: true, rank: 7)
hairlesson = Pet.create(adoptable: true, age: 1, breed: 'Sphynx', name: 'George Hairlesson', shelter_id: heavenly.id)
charlie = Pet.create(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: heavenly.id)

#Generic shelter with no pets assigned
shelter = Shelter.create(name: 'All Animals', city: 'Somewhere, CO', foster_program: false, rank: 6)

#Shelters with applicants and pets attched to applications
aurora = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
mike = Application.create(
              name: 'Mike Dao',
              street_address: '245 Maple St',
              city: 'Centennial',
              state: 'Colorado',
              zip_code: '80112',
              applicant_bio: 'My dog needs another to help chase bears up trees.',
              application_status: 'Pending')
brutus = Pet.create(adoptable: true, age: 3, breed: 'Karelian', name: 'Brutus', shelter_id: aurora.id)
mike_brutus = ApplicationPet.create(application_id: mike.id, pet_id: brutus.id)

summit = Shelter.create(name: 'Summit County', city: 'Akron, OH', foster_program: false, rank: 8)
chris = Application.create(
              name: 'Chris Simmons',
              street_address: '533 Oak St',
              city: 'Columbus',
              state: 'Ohio',
              zip_code: '43004',
              applicant_bio: 'Because how much more work could a third cat be?',
              application_status: 'Pending')
chloe = Pet.create(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: summit.id)
chris_chloe = ApplicationPet.create(application_id: chris.id, pet_id: chloe.id)

foothills = Shelter.create(name: 'Foothills Animal Shelter', city: 'Golden, CO', foster_program: false, rank: 9)
bwf = Shelter.create(name: 'Bunny World Foundation', city: 'Los Angeles, CA', foster_program: true, rank: 9)
dani = Application.create(
              name: 'Dani Coleman',
              street_address: '912 Willow St',
              city: 'Arvada',
              state: 'Colorado',
              zip_code: '80003',
              applicant_bio: 'Because I am just awesome.',
              application_status: 'Pending')
mina = Pet.create(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: bwf.id)
vida = Pet.create(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: foothills.id)
dani_mina = ApplicationPet.create!(application_id: dani.id, pet_id: mina.id)
dani_vida = ApplicationPet.create!(application_id: dani.id, pet_id: vida.id)
