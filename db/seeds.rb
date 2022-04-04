ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

@shelter = Shelter.create!(foster_program: true, name: "GoodPets", city: "Denver", rank: 6000)

@pet1 = @shelter.pets.create!(adoptable: true, age: 3, breed: "Shepard", name: "Alfonso")
@pet2 = @shelter.pets.create!(adoptable: true, age: 6, breed: "Shepard", name: "Geoffrey")
@pet3 = @shelter.pets.create!(adoptable: true, age: 7, breed: "Shepard", name: "Alfonso")

@application = @pet1.applications.create!(name: "Billy Swanson", street_address: "543 Cherry St", city: "Denver", state: "CO", zip_code: "80033")
