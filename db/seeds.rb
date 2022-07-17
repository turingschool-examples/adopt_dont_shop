Pet.destroy_all
Application.destroy_all
Shelter.destroy_all

mystery = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: mystery.id)
scrappy = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: mystery.id)

heavenly = Shelter.create!(name: 'Heavenly pets', city: 'Aurora, CO', foster_program: true, rank: 7)
hairlesson = Pet.create!(adoptable: true, age: 1, breed: 'Sphynx', name: 'George Hairlesson', shelter_id: heavenly.id)
charlie = Pet.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: heavenly.id)

aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
mike = Application.create!(
              name: 'Mike Dao',
              street_address: '245 Maple St',
              city: 'Centennial',
              state: 'Colorado',
              zip_code: '80112',
              applicant_bio: 'My dog needs another to chase up trees.',
              application_status: 'Pending')
# brutus = mike.pets.create!(adoptable: true, age: 3, breed: 'Karelian', name: 'Brutus', shelter_id: aurora.id)

chris = Application.create!(
              name: 'Chris Simmons',
              street_address: '533 Oak St',
              city: 'Columbus',
              state: 'Ohio',
              zip_code: '43004',
              applicant_bio: 'Because how much more work could a third cat be?',
              application_status: 'In Progress')
# chloe = chris.pets.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: aurora.id)

dani = Application.create!(
              name: 'Dani Coleman',
              street_address: '912 Willow St',
              city: 'Arvada',
              state: 'Colorado',
              zip_code: '80003',
              applicant_bio: 'Because I am just awesome.',
              application_status: 'Pending')
# mina = dani.pets.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: aurora.id)
# vida = dani.pets.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: aurora.id)
