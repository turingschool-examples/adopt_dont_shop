Shelter.destroy_all
Application.destroy_all

@shelter1 = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
@shelter2 = Shelter.create(name: 'Animal Shelter', city: 'Denver, CO', foster_program: true, rank: 6)
@shelter3 = Shelter.create(name: 'Humane Shelter', city: 'Denver, CO', foster_program: false, rank: 9)
@application1 = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", description: "I like degs", status: "Pending")
@application2 = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", description: "I like degs", status: "Pending")
@application3 = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", description: "I like degs", status: "Pending")
@application1.pets.create!(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: @shelter1.id)
@application3.pets.create!(adoptable: true, age: 6, breed: 'heeler' , name: 'Larry', shelter_id: @shelter3.id)