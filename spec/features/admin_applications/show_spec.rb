require 'rails_helper'

RSpec.describe 'show page' do
  it "can approve a pet" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'Pending')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    ApplicationPet.create!(application_id: application.id, pet_id: pet_1.id)
    ApplicationPet.create!(application_id: application.id, pet_id: pet_2.id)

    visit "/admin/applications/#{application.id}"

    within("#pet-#{pet_1.id}") do
      expect(page).to have_content(pet_1.name)
      click_on("Approve this pet")
    end

    expect(current_path).to eq("/admin/applications/#{application.id}")

    within("#pet-#{pet_1.id}") do
      expect(page).not_to have_button("Approve this pet")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content("Approved")
    end

#     As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved


  end
end
