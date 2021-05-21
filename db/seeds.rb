# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
lucille_bald = aurora.create!(adoptable: false, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: aurora.id)
lobster = aurora.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)

hollywood = Shelter.create!(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
george_hairlesson = hollywood.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: hollywood.id)
luke_skywalker = hollywood.create!(adoptable: false, age: 5, breed: 'aussie', name: 'Luke Skywalker', shelter_id: hollywood.id)

best_vets = VeterinaryOffice.create!(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
taylor = best_vets.create!(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: best_vets.id)
jim = best_vets.create!(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: best_vets.id)

aspen_arbor = VeterinaryOffice.create!(name: 'Aspen Arbor', boarding_services: false, max_patient_capacity: 40)
ashley = Veterinarian.create!(name: 'Ashley', review_rating: 6, on_call: true, veterinary_office_id: aspen_arbor.id)
lacey = Veterinarian.create!(name: 'Lacey', review_rating: 10, on_call: false, veterinary_office_id: aspen_arbor.id)
