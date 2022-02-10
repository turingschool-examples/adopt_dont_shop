require 'faker'
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

3.times do
  Shelter.create(name: Faker::Company.name,
                foster_program: Faker::Boolean::boolean(true_ratio: 0.66),
                city: Faker::Address.city,
                rank: rand(1..3))
end

10.times do 
  Pet.create(name: Faker::Creature::Dog.name,
            adoptable: Faker::Boolean::boolean(true_ratio: 0.8),
            age: rand(0..18),
            breed: Faker::Creature::Dog.breed,
            shelter_id: Shelter.all.sample.id)
end



5.times do
  VeterinaryOffice.create(name: Faker::Company.name,
                          boarding_services: Faker::Boolean::boolean(true_ratio: 0.8),
                          max_patient_capacity: rand(8..15))
end

10.times do
  Veterinarian.create(name: Faker::Name.name,
                      on_call: Faker::Boolean::boolean(true_ratio: 0.75),
                      review_rating: rand(5..10),
                      veterinary_office_id: VeterinaryOffice.all.sample.id)
  end
