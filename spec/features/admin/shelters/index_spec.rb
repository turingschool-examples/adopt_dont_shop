require 'rails_helper'

RSpec.describe "admin" do
  let!(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:shelter_3) { Shelter.create(name: 'Zoulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)}
  let!(:shelter_2) { Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)}
  let!(:pet_1) { Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:pet_2) { Pet.create!(name: 'Scoobyroo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_3.id)}
  let!(:pet_3) { Pet.create!(name: 'Scoo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_2.id)}
  let!(:pet_4) { Pet.create!(name: 'Jerry', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:application_1) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" ) }
  let!(:application_2) { Application.create!(name: 'Boe', street_address: "124 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs also", status: "In Progress" ) }
  let!(:application_3) { Application.create!(name: 'Foe', street_address: "125 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs also", status: "In Progress" ) }
  let!(:applicationpet_1) {ApplicationPet.create!(application_id: application_1.id, pet_id: pet_2.id )}

  it 'displays shelters in reverse alphabetical order' do
    visit '/admin/shelters'
    
    expect(shelter_3.name).to appear_before(shelter.name)
  end
  
  it 'Has a section for shelters with pending applications' do
    visit '/admin/shelters'
    
    expect(page).to have_content("Shelters with Pending Applications")
    expect(page).to have_content(shelter_3.name, count: 2)
  end

  it 'shelters with pending applications is ordered by name' do
    shelter_4 = create(:shelter, name: "Big Shelter")
    pet_5 = create(:pet, shelter_id: shelter_4.id)
    application_4 = create(:application, status: "Pending")
    ApplicationPet.create!(application_id: application_4.id, pet_id: pet_5.id)
    
    visit '/admin/shelters'
    
    within('div') do
      expect(shelter_4.name).to appear_before(shelter_3.name)
    end
  end
end