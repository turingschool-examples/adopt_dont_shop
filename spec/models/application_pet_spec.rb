require 'rails_helper'

RSpec.describe ApplicationPet do
  it {should belong_to :pet}
  it {should belong_to :application}

  it 'can change status from pending to approved' do 
    shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
    pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
    pet_2 = shelter.pets.create!(name: "Sammy", age: 5, breed: 'lab', adoptable: true)
    application_1 = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
    app_pets = ApplicationPet.create!(pet: pet_2, application: application_1)

    expect(app_pets.status).to eq("Pending")

    app_pets.approve

    expect(app_pets.status).to eq("Approved")
  end
end