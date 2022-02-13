
VeterinaryOffice.destroy_all
Veterinarian.destroy_all
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all

ruffn_tuff = VeterinaryOffice.create!(name: "Ruffn Tuff", max_patient_capacity: 20, boarding_services: true)
jo = ruffn_tuff.veterinarians.create!(name: "Jo", review_rating: 9, on_call: true)
bo = ruffn_tuff.veterinarians.create!(name: "Bo", review_rating: 7, on_call: false)
flo = ruffn_tuff.veterinarians.create!(name: "Flo", review_rating: 10, on_call: true)
po = ruffn_tuff.veterinarians.create!(name: "Po", review_rating: 4, on_call: false)

fat_catz = VeterinaryOffice.create!(name: "Fat Catz", max_patient_capacity: 14, boarding_services: false)
pat = fat_catz.veterinarians.create!(name: "Pat", review_rating: 5, on_call: false)
matt = fat_catz.veterinarians.create!(name: "Matt", review_rating: 2, on_call: false)
rat = fat_catz.veterinarians.create!(name: "Rat", review_rating: 4, on_call: true)
dat = fat_catz.veterinarians.create!(name: "Dat", review_rating: 3, on_call: false)

homing_homies = Shelter.create!(name: "Homing Homies", city: "Houston", rank: 1, foster_program: true)
hank = homing_homies.pets.create!(name: "Hank", breed: "Aussie", adoptable: true, age: 6)
happy = homing_homies.pets.create!(name: "Happy", breed: "Pit Bull", adoptable: true, age: 1)
honus = homing_homies.pets.create!(name: "Honus", breed: "Blood Hound", adoptable: false, age: 2)
harry = homing_homies.pets.create!(name: "Harry", breed: "Golden", adoptable: true, age: 8)

club_cuddles = Shelter.create!(name: "Club Cuddles", city: "Colorado Springs", rank: 2, foster_program: true)
charlie = club_cuddles.pets.create!(name: "Charlie", breed: "Ridgback", adoptable: false, age: 13)
carol = club_cuddles.pets.create!(name: "Carol", breed: "Lab", adoptable: true, age: 4)
chester = club_cuddles.pets.create!(name: "Chester", breed: "Shih Tzu", adoptable: true, age: 3)
clyde = club_cuddles.pets.create!(name: "Clyde", breed: "Bernese", adoptable: true, age: 10)

murph = Application.create!(name: "Murph", street_address: "456 Acres Ln", city: "Boca Rotan", state: "FL", zip_code: "33481", description: "Jack would have a brother", status: "In Progress")
cyle = Application.create!(name: "Cyle", street_address: "139 Corvette St", city: "Inman", state: "SC", zip_code: "29349", description: "I would take him disc'n", status: "In Progress")
drew = Application.create!(name: "Drew", street_address: "975 Mountain Rd", city: "Salt Lake City", state: "UT", zip_code: "84044", description: "I love puppies", status: "Accepted")
gordon = Application.create!(name: "Gordon", street_address: "222 Wildcat Way", city: "St. Marys", state: "OH", zip_code: "45885", description: "I live close to a road", status: "Rejected")
alex = Application.create!(name: "Alex", street_address: "728 Adventure Cir", city: "Seattle", state: "WA", zip_code: "98101", description: "We would go hiking", status: "In Progress")