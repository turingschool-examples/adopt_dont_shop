# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


aurora = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
rgv = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
fancy = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
stop_n_shop = Shelter.create(name: 'Stop And Shop', city: 'Portland, ME', foster_program: true, rank: 2)

pirate = aurora.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
clawdia = aurora.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
lucille = aurora.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
affy = aurora.pets.create(name: 'Affy', breed: 'Afghan Hound', age: 1, adoptable: true)
taco = aurora.pets.create(name: 'Taco', breed: 'Chihuahua', age: 2, adoptable: true)
bell = aurora.pets.create(name: 'Bell', breed: 'Chihuahua', age: 2, adoptable: true)
charlie = aurora.pets.create(name: 'Charlie', breed: 'sphynx', age: 2, adoptable: true)

joe = rgv.pets.create(name: 'Joe', breed: 'bulldog', age: 2, adoptable: true)
kaity = rgv.pets.create(name: 'Kaity', breed: 'Siamese', age: 8, adoptable: true)
bo = rgv.pets.create(name: 'Bo', breed: 'Borzoi', age: 4, adoptable: true)

coony = fancy.pets.create(name: 'Coony', breed: 'Maine Coon', age: 10, adoptable: true)
bloom = fancy.pets.create(name: 'Irishman', breed: 'irish wolfhound', age: 2, adoptable: true)
sage = fancy.pets.create(name: 'Sage', breed: 'irish wolfhound', age: 8, adoptable: true)

special_friends = VeterinaryOffice.create(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
pet_er_room = VeterinaryOffice.create(name: 'Pet Emergency Room', boarding_services: true, max_patient_capacity: 50)
country_vet = VeterinaryOffice.create(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)
our_house = VeterinaryOffice.create(name: 'Our House', boarding_services: false, max_patient_capacity: 10)

morgan = special_friends.veterinarians.create(name: 'Morgan', on_call: true, review_rating: 10)
heather = special_friends.veterinarians.create(name: 'Heather', on_call: true, review_rating: 9)
steve = special_friends.veterinarians.create(name: 'Steve', on_call: true, review_rating: 4)
jake = special_friends.veterinarians.create(name: 'Jake', on_call: false, review_rating: 7)

john = country_vet.veterinarians.create(name: 'John', on_call: true, review_rating: 9)
braun = country_vet.veterinarians.create(name: 'Braun', on_call: false, review_rating: 6)
tommy = country_vet.veterinarians.create(name: 'Tommy', on_call: true, review_rating: 8)

victor = pet_er_room.veterinarians.create(name: 'Victor', on_call: true, review_rating: 10)
mike = pet_er_room.veterinarians.create(name: 'Mike', on_call: false, review_rating: 6)

#Applications
app1 = Application.create!(name: "Tucker", street_address: "1122 Blank St.", city: 'New York City', state: "NY", zip_code: "12121", description: "We have one happy dog and would love another!", status: "In Progress") 
app2 = Application.create!(name: "Sara", street_address: "2211 Other St.", city: 'Iowa City', state: "IA", zip_code: "33434", description: "Give pet please", status: "Pending") 
