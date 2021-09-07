require "rails_helper"


RSpec.describe 'admin shelter index page' do

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_2.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  it 'see all shelters with pending applications' do
    app_1 = Application.create!(name: 'Billy',
      city: 'Denver',
      street_address: '123 lion st',
      state: 'CO',
      zip: 12345,
      status: "Pending"
    )
    app_2 = Application.create!(name: 'Hugh',
      city: 'Aurora',
      street_address: '789 maple',
      state: 'CO',
      zip: 12365,
      status: "In progress"
    )

    @pet_1.applications << app_1
    @pet_2.applications << app_1
    @pet_4.applications << app_2
    @pet_3.applications << app_1

    visit "/admin/shelters"

    within('#Shelters-Pending') do
      expect(page).to have_content("Shelters with pending applications")
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_3.name)
      expect(page).to_not have_content(@shelter_2.name)
    end


  end

end
