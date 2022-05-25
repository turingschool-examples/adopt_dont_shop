require 'rails_helper'

RSpec.describe Application, type: :model do
  it { should have_many(:pet_applications) }
  it { should have_many(:pets).through(:pet_applications) }

  it ".approved_application" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    app_1 = Application.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending")
    app_2 = Application.create(name: "Violet", street_address: "678 Main st", city: "Denver", state: "CO", zip_code: "83302", application_status: "Pending")
    pet_app1 = PetApplication.create!(application_id: app_1.id, pet_id: pet_1.id, approved: true)
    pet_app2 = PetApplication.create!(application_id: app_1.id, pet_id: pet_2.id, approved: true)
    pet_app3 = PetApplication.create!(application_id: app_1.id, pet_id: pet_3.id, approved: true)
    pet_app4 = PetApplication.create!(application_id: app_2.id, pet_id: pet_1.id, approved: true)

    expect(app_1.approved_application).to eq("Approved")
  end

  it ".rejected_application" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    app_1 = Application.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending")
    app_2 = Application.create(name: "Violet", street_address: "678 Main st", city: "Denver", state: "CO", zip_code: "83302", application_status: "Pending")
    pet_app1 = PetApplication.create!(application_id: app_1.id, pet_id: pet_1.id, approved: false)
    pet_app2 = PetApplication.create!(application_id: app_1.id, pet_id: pet_2.id, approved: true)
    pet_app3 = PetApplication.create!(application_id: app_1.id, pet_id: pet_3.id, approved: true)
    pet_app4 = PetApplication.create!(application_id: app_2.id, pet_id: pet_1.id, approved: true)

    expect(app_1.rejected_application).to eq("Rejected")
  end
end
