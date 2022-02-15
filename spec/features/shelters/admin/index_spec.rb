require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists all shelters in reverse aphabetical order' do
    visit "/admin/shelters"

    within("#index-1") do
      expect(page).to have_content(@shelter_2.name)
    end

    within("#index-2") do
      expect(page).to have_content(@shelter_3.name)
    end

    within("#index-3") do
      expect(page).to have_content(@shelter_1.name)
    end
  end

  it 'lists the shelters with pending applications' do
    app_1 = Application.create!(
      name: "Jerry Blank",
      street_address: "246 DumDum Ave.",
      city: "Melbourne",
      state: "IL",
      zip_code: 53262,
      status: "In Progress"
    )
    app_2 = Application.create!(
      name: "Jeff Jippers",
      street_address: "123 Affirmative Ave.",
      city: "Claytown",
      state: "AL",
      zip_code: 34567,
      status: "Pending"
    )
    PetApplication.create!(pet_id: @pet_1.id, application_id: app_2.id)
    PetApplication.create!(pet_id: @pet_3.id, application_id: app_2.id)
    PetApplication.create!(pet_id: @pet_1.id, application_id: app_1.id)
    PetApplication.create!(pet_id: @pet_2.id, application_id: app_1.id)

    visit "/admin/shelters"

    expect(page).to have_content("Shelter's(sic) with Pending Applications")
    within(".pending-apps") do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_3.name)

      expect(page).to_not have_content(@shelter_2.name)
    end
  end

  it 'has no such section if there are no shelters with pending applications' do
    visit "/admin/shelters"

    expect(page).to_not have_content("Shelter's(sic) with Pending Applications")
  end
end
