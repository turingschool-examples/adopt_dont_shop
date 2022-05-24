require 'rails_helper'

RSpec.describe 'admin application show page' do 
  let!(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  
  let!(:pet_1) { shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  let!(:pet_2) { shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }
 
  let!(:app_1) { pet_1.applications.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending") }
 
  it 'can approve an application for a pet' do 
    PetApplication.create!(application_id: app_1.id, pet_id: pet_2.id)

    visit "/admin/applications/#{app_1.id}"

    within("##{pet_1.id}") do 
      click_button "Approve"
      expect(current_path).to eq("/admin/applications/#{app_1.id}")
      expect(page).to_not have_content("Approve") #Clicking the approve button removes the button for that pet 
      expect(page).to have_content("Approved") #It will show that the pet has been approved for that application
    end 
  end
end