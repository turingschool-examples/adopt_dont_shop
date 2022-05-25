require 'rails_helper'

RSpec.describe 'admin application show page' do
  let!(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:pet_1) { shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  let!(:pet_2) { shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }
  let!(:pet_3) { shelter.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true) }
  let!(:app_1) { Application.create(name: "Bob", street_address: "234 York st", city: "Denver", state: "CO", zip_code: "83201", application_status: "Pending") }
  let!(:app_2) { Application.create(name: "Violet", street_address: "678 Main st", city: "Denver", state: "CO", zip_code: "83302", application_status: "Pending") }
  let!(:pet_app1) { PetApplication.create!(application_id: app_1.id, pet_id: pet_1.id) }
  let!(:pet_app2) { PetApplication.create!(application_id: app_1.id, pet_id: pet_2.id) }
  let!(:pet_app3) { PetApplication.create!(application_id: app_1.id, pet_id: pet_3.id) }
  let!(:pet_app4) { PetApplication.create!(application_id: app_2.id, pet_id: pet_1.id) }

  it 'can approve an application for a pet' do
    visit "/admin/applications/#{app_1.id}"

    within("##{pet_app1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
      click_button "Approve"
      expect(current_path).to eq("/admin/applications/#{app_1.id}")
      expect(page).to have_no_button("Approve")
      expect(page).to have_content("Approved")
    end

    within("##{pet_app2.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
      expect(page).to_not have_content("Approved")
    end

    within("##{pet_app3.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
      click_button "Reject"
      expect(page).to have_content("Rejected")
      expect(page).to_not have_content("Approved")
    end
  end

  it 'Approved/Rejected Pets on one Application do not affect other Applications' do

    visit "/admin/applications/#{app_1.id}"
    within("##{pet_app1.id}") do
    expect(page).to have_content('Mr. Pirate')

      click_button "Approve"
      expect(page).to have_content("Approved")
    end

    visit "/admin/applications/#{app_2.id}"
    within("##{pet_app4.id}") do
      expect(page).to have_content('Mr. Pirate')
      expect(page).to have_button("Approve")
    end
  end

# All Pets Accepted on an Application
#
# As a visitor
# When I visit an admin application show page
# And I approve all pets for an application
# Then I am taken back to the admin application show page
# And I see the application's status has changed to "Approved"

  it "can see application's status is changed to 'Approved' when all pets are accepted on an application" do
    visit "/admin/appplications/#{app_2.id}"
    within("##{pet_app4.id}") do
      click_button('Approve')

      expect(current_path).to eq("/admin/applications/#{app_2.id}")
      expect(page).to have_content("Application Status: Approved")
    end
  end
end
