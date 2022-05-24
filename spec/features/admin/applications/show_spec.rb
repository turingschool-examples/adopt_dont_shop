require 'rails_helper'

RSpec.describe 'admin application show page' do
  let!(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:pet_1) { shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  # let!(:pet_2) { shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }
  # let!(:pet_3) { shelter.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true) }
  let!(:app_1) { Application.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending") }
  let!(:pet_app1) { PetApplication.create!(application_id: app_1.id, pet_id: pet_1.id) }
  # let!(:pet_app2) { PetApplication.create!(application_id: app_1.id, pet_id: pet_2.id) }
  # let!(:pet_app3) { PetApplication.create!(application_id: app_1.id, pet_id: pet_3.id) }

  it 'can approve an application for a pet' do
    visit "/admin/applications/#{app_1.id}"

    within("##{pet_app1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
      click_button "Approve"
      # save_and_open_page
    end
    expect(current_path).to eq("/admin/applications/#{app_1.id}")
    expect(page).to have_no_button("Approve")
    expect(page).to have_content("Approved")
    #
    # within("##{pet_app2.id}") do
    #   expect(page).to have_button("Approve")
    #   expect(page).to have_button("Reject")
    #   expect(page).to_not have_content("Approved")
    # end
    #
    # within("##{pet_app3.id}") do
    #   expect(page).to have_button("Approve")
    #   expect(page).to have_button("Reject")
    #   click_button "Reject"
    #   save_and_open_page
    #   expect(page).to have_content("Rejected")
    #   expect(page).to_not have_content("Approved")
    # end
  end
end
