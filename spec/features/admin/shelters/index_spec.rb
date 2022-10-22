
require 'rails_helper'

RSpec.describe 'Admin shelters index' do
  it 'shows all the shelters in the system listed in reverse alphabetical order' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    visit "/admin/shelters"
    # save_and_open_page
    expect("RGV animal shelter").to appear_before("Fancy pets of Colorado")
    expect("Fancy pets of Colorado").to appear_before("Aurora shelter")
  end

  it "shows shelters with pending applications" do
    application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")
    shelter_1 = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
    shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    becky = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky", shelter: shelter_1)

    ApplicationPet.create!(pet: becky, application: application)

    visit "/admin/shelters"
    #  save_and_open_page

    expect(page).to have_content("Shelters with Pending Applications:\nTest Shelter")

  end
end
