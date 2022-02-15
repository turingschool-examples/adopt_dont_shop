require 'faker'

PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

6.times do
    Shelter.create(name: Faker::Company.name,
                foster_program: Faker::Boolean::boolean(true_ratio: 0.66),
                city: Faker::Address.city,
                rank: rand(1..3))
end

50.times do
    Pet.create(name: Faker::Creature::Cat.name,
              adoptable: true,
              age: rand(0..20),
              breed: Faker::Creature::Cat.breed,
              shelter_id: Shelter.all.sample.id)
end

10.times do
    application = Application.create(name: Faker::Name.name,
                street_address:Faker::Address.street_address,
                city: Faker::Address.city,
                state: Faker::Address.state,
                zipcode: Faker::Address.street_address.to_i,
                status: 'In Progress')
    application = Application.create(name: Faker::Name.name,
                street_address:Faker::Address.street_address,
                city: Faker::Address.city,
                state: Faker::Address.state,
                zipcode: Faker::Address.street_address.to_i,
                description: "I'd love a new best friend!",
                status: 'Pending')
application.adopt(Pet.all.sample)
application.adopt(Pet.all.sample)
      end

6.times do
    VeterinaryOffice.create(name: Faker::Company.name,
                            boarding_services: Faker::Boolean::boolean(true_ratio: 0.6),
                            max_patient_capacity: rand(5..30))
end
  
15.times do
    Veterinarian.create(name: Faker::Name.name,
                        on_call: Faker::Boolean::boolean(true_ratio: 0.6),
                        review_rating: rand(1..5),
                        veterinary_office_id: VeterinaryOffice.all.sample.id)
end


# application_1 = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", description: "I really love animals.", status: "Pending")
# application_2 = Application.create!(name: "Roman Reigns", street_address: "2354 Narwal ct", city: "Littleton", state: "CO", zipcode: "23785")
# application_3 = Application.create!(name: "Denet Lament", street_address: "1987 Orange Tree st", city: "Lakewood", state: "CO", zipcode: "12343")
# application_4 = Application.create!(name: "Riley Wiley", street_address: "8974 Witch blvd", city: "Lone Tree", state: "CO", zipcode: "98765")
# application_5 = Application.create!(name: "Pabu Strong", street_address: "771 Ditch ave", city: "Frederick", state: "CO", zipcode: "80543")
# application_6 = Application.create!(name: "Theresa Ann", street_address: "09092 Blossom st", city: "Huntington Beach", state: "CA", zipcode: "98765")
# application_7 = Application.create!(name: "Gretchen Grump", street_address: "67890 Bog st", city: "Castle Rock", state: "CO", zipcode: "98765", description: "None of your business.", status: "Pending")
# application_8 = Application.create!(name: "Harry Potter", street_address: "81274 Hogwarts ct", city: "Hogwarts", state: "KS", zipcode: "83754")


# dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
# smart_friends_league = Shelter.create!(foster_program: true, name: "Smart Friends League", city: "Lakewood", rank: "2")

# mushu = application_1.pets.create!(adoptable: true, age: "5", breed: "dog", name:"Mushu", shelter: dumb_friends_league )
# mantis = application_1.pets.create!(adoptable: true, age: "2", breed: "cat", name:"Mantis", shelter: dumb_friends_league )
# tesla = application_2.pets.create!(adoptable: false, age: "9", breed: "cat", name:"Tesla", shelter: dumb_friends_league )
# bowie = application_2.pets.create!(adoptable: true, age: "1", breed: "dog", name:"Bowie", shelter: smart_friends_league )
# oreo = application_3.pets.create!(adoptable: false, age: "13", breed: "dog", name:"Oreo", shelter: dumb_friends_league )
# rosco = application_4.pets.create!(adoptable: true, age: "2", breed: "dog", name:"Rosco", shelter: smart_friends_league )
# diesel = application_5.pets.create!(adoptable: false, age: "5", breed: "dog", name:"Diesel", shelter: dumb_friends_league )
# taquana = application_6.pets.create!(adoptable: true, age: "9", breed: "cat", name:"Taquana", shelter: smart_friends_league )
# mary =application_7.pets.create!(adoptable: true, age: "13", breed: "cat", name:"Mary", shelter: dumb_friends_league )
# leah = application_7.pets.create!(adoptable: false, age: "5", breed: "horse", name:"Leah", shelter: dumb_friends_league )
# queen = application_8.pets.create!(adoptable: true, age: "6", breed: "owl", name:"Queenie", shelter: smart_friends_league )

