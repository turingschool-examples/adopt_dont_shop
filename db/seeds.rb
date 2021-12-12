# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

shelters = [
  [true, "shelter_1", "Dallas", 1],
  [false, "shelter_2", "Ann Arbor", 3],
  [true, "shelter_3", "Fort Worth", 2]
]

pets = [
  [true, 10, "Hound", "Pete", 1],
  [false, 3, "GSP", "Newton", 1],
  [false, 13, "German Shepard", "Molly", 1],
  [true, 5, "Australian Shepard", "Bob", 2],
  [false, 3, "German Shepard", "Lindy", 2],
  [true, 8, "Australian Shepard", "Tenny", 2],
  [true, 2, "Labradoodle", "Oz", 3],
  [true, 7, "White Dog", "Beau", 3],
  [false, 3, "Black Lab", "Emma", 3],
  [false, 1, "Black Lab", "Poppy", 3]
]

applications = [
  ['Steve', '135 Waddle Road', 'Dallas', 'TX', 75001, "I really want a dog", "In Progress"],
  ['Mary', 'PO Box 181 Julian Street', 'Fort Worth', 'TX', 75043, "I really want a dog", "Pending"],
  ['Abby', '1039 Galapago Street', 'Denver', 'CO', 80204, "I really, really want a dog", "Accepted"],
  ['Charlie', '1431 Washington Blvd', 'Detroit', 'MI', 16870, "I don't really want a dog", "Rejected"]
]

pet_applications = [
  [1,1],
  [2,1],
  [5,1],
  [2,2],
  [3,2],
  [7,2],
  [1,3],
  [1,4],
  [2,4],
  [7,4],
  [8,4]
]

shelters.each do |foster_program, name, city, rank|
  Shelter.create(foster_program: foster_program, name: name, city: city, rank: rank)
end

pets.each do |adoptable, age, breed, name, shelter_id|
  Pet.create(adoptable: adoptable, age: age, breed: breed, name: name, shelter_id: shelter_id)
end

applications.each do |name, address, city, state, zip, description, status|
  Application.create(name: name, address: address, city: city, state: state, zip: zip, description: description, status: status)
end

pet_applications.each do |pet_id, application_id|
  PetApplication.create(pet_id: pet_id, application_id: application_id)
end
