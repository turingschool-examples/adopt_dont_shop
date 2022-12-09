Shelter.destroy_all
Application.destroy_all
Pet.destroy_all
ApplicationPet.destroy_all

shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")
pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)
app_pet_1 = ApplicationPet.create!(pet_id: pet_2.id, application_id: application_1.id)