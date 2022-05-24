require 'rails_helper'

RSpec.describe 'admin application show page' do
  let!(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }

  let!(:pet_1) { shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  let!(:pet_2) { shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }

  let!(:app_1) { Application.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending") }

  it 'can approve an application for a pet' do
    pet_app1 = PetApplication.create!(application_id: app_1.id, pet_id: pet_1.id, approved: nil)
    pet_app2 = PetApplication.create!(application_id: app_1.id, pet_id: pet_2.id)

    visit "/admin/applications/#{app_1.id}"
    within("##{pet_app1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Deny")

      click_button "Approve"
      save_and_open_page

      expect(current_path).to eq("/admin/applications/#{app_1.id}")
      expect(page).to have_no_button("Approve")
      expect(page).to have_content("Approved")
    end
    within("##{pet_app2.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Deny")
      expect(page).to_not have_content("Approved")
    end
  end
end
