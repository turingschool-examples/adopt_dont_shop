require 'rails_helper'

RSpec.describe "admin" do
  let!(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:shelter_3) { Shelter.create(name: 'Zoulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)}
  let!(:shelter_2) { Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)}
  let!(:pet_1) { Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:pet_2) { Pet.create!(name: 'Scoobyroo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_3.id)}
  let!(:pet_3) { Pet.create!(name: 'Scoo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_2.id)}
  let!(:pet_4) { Pet.create!(name: 'Jerry', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:application_1) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: "kona", status: "pending" ) }
  let!(:application_2) { Application.create!(name: 'Boe', street_address: "124 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs also", pet_names: "lilo", status: "pending" ) }
  let!(:application_3) { Application.create!(name: 'Foe', street_address: "125 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs also", pet_names: "Dog", status: "in progress" ) }
  let!(:applicationpet_1) {ApplicationPet.create!(application_id: application_1.id, pet_id: pet_2.id )}
  it 'displays shelters in reverse alphabetical order' do
    
    visit '/admin/shelters'
    #  save_and_open_page
    # binding.pry
    expect(shelter_3.name).to appear_before(shelter.name)
  end
  
  #   As a visitor
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see a section for "Shelter's with Pending Applications"
  # And in this section I see the name of every shelter that has a pending application
  
  it 'Has a section for shelters with pending applications' do
    visit '/admin/shelters'
    
    expect(page).to have_content("Shelters with Pending Applications")
     save_and_open_page
  end
end