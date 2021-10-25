# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelters = [
  [true, "Downtown Animal Shelter", "Phoenix", 2],
  [true, "Mesa Animal Adoption Center", "Mesa", 1],
  [false, "Chandler Animal Shelter", "Chandler", 4]
]

shelters.each do |foster_program, name, city, rank|
  Shelter.create!(foster_program: foster_program, name: name, city: city, rank: rank)
end

pets = [
  [true, 4, "German Shepherd", "Sparky"],
  [true, 3, "Bombay", "Binx"],
  [true, 7, "Poodle", "Lady"],
  [false, 10, "Egyptian Mau", "Pixie"],
  [true, 2, "Australian Shepherd", "Skittles"],
  [false, 4, "Corgi", "Bacon"],
  [true, 13, "Norwegian Forest Cat", "Freya"],
  [true, 1, "Chihuahua", "Tank"],
  [false, 9, "Devon Rex", "Nikita"],
  [true, 6, "Boston Terrier", "Jellybean"]
]

pets.each do |adoptable, age, breed, name|
  Pet.create!(adoptable: adoptable, age: age, breed: breed, name: name, shelter_id: Shelter.order('RANDOM()').first.id)
end

veterinary_offices = [
  [true, 30, "Phoenix Animal Hospital"],
  [true, 20, "Kennel Care"],
  [false, 25, "Animal Emergency Docs"]
]

veterinary_offices.each do |boarding_services, max_patient_capacity, name|
  VeterinaryOffice.create!(boarding_services: boarding_services, max_patient_capacity: max_patient_capacity, name: name)
end

veterinarians = [
  [true, 95, "Dr. Khong"],
  [false, 85, "Dr. Conaway"],
  [false, 80, "Dr. Granger"],
  [true, 99, "Dr. Poznauskis"],
  [true, 83, "Dr. Poe"],
  [false, 79, "Dr. Prevost"],
  [true, 96, "Dr. Gopal"]
]

veterinarians.each do |on_call, review_rating, name|
  Veterinarian.create!(on_call: on_call, review_rating: review_rating, name: name, veterinary_office_id: VeterinaryOffice.order('RANDOM()').first.id)
end
