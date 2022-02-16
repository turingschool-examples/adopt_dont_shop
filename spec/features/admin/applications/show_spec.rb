require 'rails_helper'

RSpec.describe 'admin application show page' do
  it 'displays the attributes of pending applications' do
    application_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, status: "Pending")
    visit "/admin/applications/#{application_1.id}"

    within('#application_info') do
      expect(page).to have_content(application_1.name)
    end
  end

  it 'displays a button to approve the application of a specific pet' do
    application_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, status: "Pending")
    application_2 = Application.create!(name: "Justin Timberlake", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, status: "Pending")

    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    PetApplication.create(pet_id: pet_1.id, application_id: application_1.id, adoption_status: "Approved")
    # application_1.pets << pet_1
    # application_2.pets << pet_3
    visit "/admin/applications/#{application_1.id}"
    within('#approving-apps') do
      click_button("Approve Application for #{pet_1.name}")
      expect(current_path).to eq("/admin/applications/#{application_1.id}")

      save_and_open_page
      expect(page).to have_content("#{pet_1.name}: Approved")
    end
  end
end
