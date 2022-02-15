require 'rails_helper'

RSpec.describe 'admin application show page' do
  it 'displays a button to approve the application of a specific pet' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_3 = Pet.create!(name: "Richard", age: 5, breed: "Maine Coone", adoptable: true, shelter_id: shelter_1.id)
    pet_4 = Pet.create!(name: "Daryll", age: 4, breed: "Sphynx", adoptable: true, shelter_id: shelter_1.id)
    application_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "Richard is a good dog name", status: "Pending")
    PetApplication.create!(pet_id: pet_3.id, application_id: application_1.id)
    PetApplication.create!(pet_id: pet_4.id, application_id: application_1.id)

    visit "/admin/applications/#{application_1.id}"

    within('#approving-apps') do
      click_button("Approve Application for #{pet_3.id}")
      expect(current_path).to eq("/admin/applications/#{application_1.id}")
      expect(page).to have_content("#{pet_3.id} Approved")
    end
  end
end
