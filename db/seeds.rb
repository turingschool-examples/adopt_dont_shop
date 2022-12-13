ApplicationPet.destroy_all
Shelter.destroy_all
Application.destroy_all
Pet.destroy_all

# shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
# shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
# shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

# application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203')
# application_2 = Application.create!(name: 'Cruela De Ville', street_address: '666 Dalmation Way', city: 'Highland Ranch', state: 'Colorado', zip_code: '80234')
# application_3 = Application.create!(name: 'Sarah McGlachlan', street_address: '444 Arms of an Angel', city: 'Aspen', state: 'Colorado', zip_code: '80444')

# pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
# pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
# pet_3 = Pet.create!(name: 'Spot', age: 3, breed: 'Dalmation', adoptable: true, shelter_id: shelter_3.id)
# pet_4 = Pet.create!(name: 'Garfield', age: 7, breed: 'Tabby', adoptable: true, shelter_id: shelter_2.id)

# app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)
# app_pet_2 = ApplicationPet.create!(pet_id: pet_2.id, application_id: application_1.id)

shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

shelter_1.pets.create!(name: 'Scooby', breed: 'Great Dane', age: 2, adoptable: true)
shelter_1.pets.create!(name: 'Scrappy', breed: 'Great Dane', age: 1, adoptable: true)
shelter_3.pets.create!(name: 'Spot', breed: 'Dalmation', age: 3, adoptable: true)
# @shelter_4.pets.create!(name: 'Garfield', breed: 'Tabby', age: 7, adoptable: true)

application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203')
application_2 = Application.create!(name: 'Cruela De Ville', street_address: '666 Dalmation Way', city: 'Highland Ranch', state: 'Colorado', zip_code: '80234')
application_3 = Application.create!(name: 'Sarah McGlachlan', street_address: '444 Arms of an Angel', city: 'Aspen', state: 'Colorado', zip_code: '80444')

pet_1 = application_1.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
pet_2 = application_1.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
pet_3 = application_2.pets.create!(name: 'Spot', age: 3, breed: 'Dalmation', adoptable: true, shelter_id: shelter_3.id)