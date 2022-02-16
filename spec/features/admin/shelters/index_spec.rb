require 'rails_helper'

RSpec.describe 'admin shelter index' do
  it 'displays shelters in the system listed in reverse alphabetical order' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'Peninsula shelter', city: 'San Francisco, CA', foster_program: false, rank: 7)
    shelter_3 = Shelter.create(name: 'Mile High shelter', city: 'Denver, CO', foster_program: false, rank: 8)

    visit "/admin/shelters"

    expect(shelter_2.name).to appear_before(shelter_1.name)
    expect(shelter_2.name).to appear_before(shelter_3.name)
  end

  it 'displays a section for shelters with pending applications' do
    application_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, status: "Pending")
    application_2 = Application.create!(name: "Justin Timberlake", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, status: "Pending")

    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    application_1.pets << pet_1
    application_2.pets << pet_3

    visit "/admin/shelters"

    within('#apps-pending') do
      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_3.name)
      expect(page).to_not have_content(shelter_2.name)
    end
  end
end
