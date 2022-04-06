require 'rails_helper'

RSpec.describe 'Admin Shelters Index' do

  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application_1 = Application.create(name: 'Alex Horn', street_address: '12 Not A Real Ln', city: 'Westminster', state: 'CO', zip_code: '80021')
    @pets_applications_1 = ApplicationsPet.create!(pet_id: @shelter_1.pets[0].id, application_id: @application_1.id)
    @pets_applications_2 = ApplicationsPet.create!(pet_id: @shelter_3.pets[0].id, application_id: @application_1.id)
  end

  it 'displays all shelters in reverse alphabetical order' do
    visit '/admin/shelters'

    first = find("#shelter-#{@shelter_2.id}")
    second = find("#shelter-#{@shelter_3.id}")
    third = find("#shelter-#{@shelter_1.id}")

    expect(first).to appear_before(second)
    expect(second).to appear_before(third)
    expect(first).to appear_before(third)

    within("#shelter-#{@shelter_2.id}") do
      expect(page).to have_content(@shelter_2.name)
    end

    within("#shelter-#{@shelter_3.id}") do
      expect(page).to have_content(@shelter_3.name)
    end

    within("#shelter-#{@shelter_1.id}") do
      expect(page).to have_content(@shelter_1.name)
    end
  end

  it 'displays a list of shelters with pending applications' do
    visit '/admin/shelters'

    expect(page).to have_content("Shelters With Pending Applications")

    within("#pending-applications") do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_3.name)
    end
  end
end