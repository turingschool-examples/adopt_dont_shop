Shelter.destroy_all
Pet.destroy_all
Application.destroy_all
PetApplication.destroy_all

@furever = Shelter.create(name: "Furever Homes", city: "Scranton", rank: 3, foster_program: true)
@adopt = Shelter.create(name: "Adopt a Pet", city: "Wilkes-Barre", rank: 1, foster_program: false)

@grinch = @furever.pets.create(name: "Grinch", breed: "Cat", age: 2, adoptable: true)
@bags = @furever.pets.create(name: "Bagheera", breed: "Cat", age: 3, adoptable: true)
@buddy = @adopt.pets.create(name: "Buddy", breed: "Dog", age: 5, adoptable: true)
@jack =  @adopt.pets.create(name: "Jackson", breed: "Dog", age: 7, adoptable: true)
@captain =  @adopt.pets.create(name: "Captain", breed: "Dog", age: 9, adoptable: true)
@marcel = @furever.pets.create(name: "Marcel", breed: "Cat", age: 10, adoptable: true)

@michael = Application.create(name: "Michael Scott", address: "2345 Main St", city: "Scranton", state: "Pennsylvania", zip_code: 12345, description: "_", status: "pending" )
@dwight = Application.create(name: "Dwight Schrute", address: "234 Beet Lane", city: "Wilkes-Barre", state: "Pennsylvania", zip_code: 23456, description: "_", status: "pending" )
@jim = Application.create(name: "Jim Halpert", address: "349 Cherry St", city: "Scranton", state: "Pennsylvania", zip_code: 34567, description: "_", status: "pending" )
@angela = Application.create(name: "Angela", address: "238 cat lady ave", city: "Wilkes Barre", state: "Pennsylvania", zip_code: 45678, description: "_", status: "pending" )

PetApplication.create(application_id: @jim.id, pet_id: @jack.id)
PetApplication.create(application_id: @angela.id, pet_id: @grinch.id)
PetApplication.create(application_id: @angela.id, pet_id: @bags.id)
PetApplication.create(application_id: @angela.id, pet_id: @marcel.id)
PetApplication.create(application_id: @michael.id, pet_id: @buddy.id)
PetApplication.create(application_id: @michael.id, pet_id: @captain.id)
PetApplication.create(application_id: @dwight.id, pet_id: @jack.id)
