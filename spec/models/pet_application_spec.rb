require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  it { should belong_to(:pet) }
  it { should belong_to(:application) }
  let!(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }

  let!(:pet_1) { shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  let!(:pet_2) { shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }

  let!(:app_1) { Application.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending") }

  let!(:pet_app1) { PetApplication.create!(application_id: app_1.id, pet_id: pet_1.id, approved: nil) }
  let!(:pet_app2) { PetApplication.create!(application_id: app_1.id, pet_id: pet_2.id) }

  it "#pet_name" do

    expect(pet_app1.pet_name).to eq('Mr. Pirate')
  end
end
