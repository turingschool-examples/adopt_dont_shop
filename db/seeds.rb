# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all


@shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: 'Happy Adoptions', city: 'Stone Mtn GA', foster_program: true, rank: 1)
@shelter_3 = Shelter.create!(name: 'Doggy World', city: 'Baltimore MD', foster_program: true, rank: 3)
@shelter_4 = Shelter.create!(name: 'Forever Home', city: 'Brooklyn NY', foster_program: false, rank: 5)

@scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
@daisy = Pet.create!(name: 'Daisy', age: 4, breed: 'Poodle', adoptable: true, shelter_id: @shelter_1.id)
@artimus = Pet.create!(name: 'Artimus', age: 7, breed: 'Mut', adoptable: true, shelter_id: @shelter_2.id)
@apollo = Pet.create!(name: 'Apollo', age: 2, breed: 'Lab', adoptable: true, shelter_id: @shelter_2.id)
@scruffy = Pet.create!(name: 'Scruffy', age: 3, breed: 'Hot Dog', adoptable: true, shelter_id: @shelter_3.id)
@pineapple = Pet.create!(name: 'Pineapple', age: 4, breed: 'Cold Dog', adoptable: true, shelter_id: @shelter_3.id)
@mango = Pet.create!(name: 'Mango', age: 9, breed: 'Fancy Dog', adoptable: true, shelter_id: @shelter_4.id)
@onion = Pet.create!(name: 'Onion', age: 1, breed: 'Sad Dog', adoptable: true, shelter_id: @shelter_4.id)
@peach = Pet.create!(name: 'Peach', age: 12, breed: 'Poodle', adoptable: true, shelter_id: @shelter_4.id)

@app_1= Application.create(first_name: 'Lemon', last_name: 'Tiger', street_address: '1225 Alvaro Obgeron Dr.', city: 'Mexico City, GA', post_code: '67518')
@app_2= Application.create(first_name: 'Salty', last_name: 'Hippo', street_address: '367 CBTIS Overton St.', city: 'Colima, DC', post_code: '14628')
@app_3= Application.create(first_name: 'Funky', last_name: 'Platypus', street_address: '15 Overpath Pkwy.', city: 'Shenzhen, OH', post_code: '97627')

ApplicationPet.create!(pet_id:@scooby.id, application_id: @app_1.id)
ApplicationPet.create!(pet_id:@daisy.id, application_id: @app_1.id)
ApplicationPet.create!(pet_id:@artimus.id, application_id: @app_1.id)
ApplicationPet.create!(pet_id:@apollo.id, application_id: @app_2.id)
ApplicationPet.create!(pet_id:@scruffy.id, application_id: @app_2.id)
ApplicationPet.create!(pet_id:@pineapple.id, application_id: @app_3.id)
ApplicationPet.create!(pet_id:@mango.id, application_id: @app_3.id)
ApplicationPet.create!(pet_id:@onion.id, application_id: @app_3.id)
ApplicationPet.create!(pet_id:@peach.id, application_id: @app_3.id)

@vet_office_1 = VeterinaryOffice.create(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
@vet_office_2 = VeterinaryOffice.create(name: 'Pet Emergency Room', boarding_services: true, max_patient_capacity: 50)
@vet_office_3 = VeterinaryOffice.create(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)
vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: @vet_office_1.id)
vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office_2.id)
