# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

  shelter1 = Shelter.create(name: 'Denver Dogs', city: 'Denver', foster_program: true, rank: 9)
    pet11 = shelter1.pets.create(name: 'Mr. Biggs', age: 2, breed: 'Great Dane', adoptable: true)
    pet12 = shelter1.pets.create(name: 'Spike', age: 3, breed: 'doberman', adoptable: true)
    pet13 = shelter1.pets.create(name: 'Carter', age: 7, breed: 'Golden Retriever', adoptable: true)
    application1 = Application.create!(name: 'Chris', street_address: '123 Main St', city: 'Hometown', state: 'CO', zipcode: "80504")
  shelter2 = Shelter.create(name: 'Colorado Cats', city: 'Vail', foster_program: true, rank: 5)
    pet21 = shelter2.pets.create(name: 'Boots', age: 4, breed: 'Tabby', adoptable: true)
    pet22 = shelter2.pets.create(name: 'Evil Steve', age: 4, breed: 'Unknown', adoptable: false)
    pet23 = shelter2.pets.create(name: 'Huckleberry', age: 17, breed: 'Tuxedo', adoptable: true)
    application2 = Application.create(name: 'Caden', street_address: '111 First Street', city: 'Denver', state: 'CO', zipcode: '07321')

    pet_application1 = PetApplication.create(pet_id: pet11.id, application_id: application1.id)
    pet_application2 = PetApplication.create(pet_id: pet12.id, application_id: application1.id)
    pet_application3 = PetApplication.create(pet_id: pet21.id, application_id: application2.id)
      

  