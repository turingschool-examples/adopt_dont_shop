
require 'rails_helper'

RSpec.describe 'Admin shelters index' do
  it 'shows all the shelters in the system listed in reverse alphabetical order' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    visit "/admin/shelters"

    within("#shelter-#{shelter_1.id}") do
      expect(page).to have_content(shelter_1.name)
    end

    within("#shelter-#{shelter_2.id}") do
      expect(page).to have_content(shelter_2.name)
    end

    within("#shelter-#{shelter_3.id}") do
      expect(page).to have_content(shelter_3.name)
    end

    expect("RGV animal shelter").to appear_before("Fancy pets of Colorado")
    expect("Fancy pets of Colorado").to appear_before("Aurora shelter")
  end

  it "shows shelters with pending applications" do
    application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")
    shelter_1 = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
    shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    becky = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky", shelter: shelter_1)
    sam = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Sam", shelter: shelter_1)
    bean = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Bean", shelter: shelter_3)

    ApplicationPet.create!(pet: becky, application: application)
    ApplicationPet.create!(pet: bean, application: application)

    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications:")
    # save_and_open_page

    within("#shelters_pending-#{shelter_1.id}") do
      expect(page).to have_content(shelter_1.name)
    end

    within("#shelters_pending-#{shelter_3.id}") do
      expect(page).to have_content(shelter_3.name)
    end
  end
end
