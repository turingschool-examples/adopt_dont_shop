require 'rails_helper'

RSpec.describe 'admin shelters index page' do
  let!(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
  let!(:shelter_3) { Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10) }

  let!(:pet_1) { shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  let!(:pet_2) { shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }
  let!(:pet_3) { shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true) }
  # let!(:pet_4) { @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true) }

  let!(:app_1) { pet_1.applications.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending") }
  let!(:app_2) { pet_2.applications.create(name: "Violet", street_address: "678 Main st", city: "Denver", state: "CO", zip_code: "83302", application_status: "In Progress") }
  let!(:app_3) { pet_3.applications.create(name: "Hannah", street_address: "MLK blvd", city: "Denver", state: "CO", zip_code: "83402", application_status: "Pending") }

  describe "#order_by_name"
  it "can see all shelters in the system listed in reverse alphabetical order by name" do
    visit '/admin/shelters'

    expect('RGV animal shelter').to appear_before('Aurora shelter')
    expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    expect('Aurora shelter').to_not appear_before('RGV animal shelter')
  end


  it 'lists shelters that have pending applications' do 
    visit '/admin/shelters'

    expect(page).to have_content("Shelters with Pending Applications")

    within("#pending") do
      expect(page).to have_content(shelter_3.name)
      expect(page).to have_content(shelter.name)
      expect(page).to_not have_content(shelter_2.name)
    end
  end
end
