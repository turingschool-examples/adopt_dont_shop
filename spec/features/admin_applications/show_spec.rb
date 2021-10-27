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
  end

  it "has a button that can reject a pet" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'Pending')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    ApplicationPet.create!(application_id: application.id, pet_id: pet_1.id)
    ApplicationPet.create!(application_id: application.id, pet_id: pet_2.id)

    visit "/admin/applications/#{application.id}"

    within("#pet-#{pet_1.id}") do
      expect(page).to have_content(pet_1.name)
      click_on("Reject this pet")
    end

    expect(current_path).to eq("/admin/applications/#{application.id}")

    within("#pet-#{pet_1.id}") do
      expect(page).not_to have_button("Reject this pet")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content("Rejected")
    end

  end

#   As a visitor
# When there are two applications in the system for the same pet
# When I visit the admin application show page for one of the applications
# And I approve or reject the pet for that application
# When I visit the other application's admin show page
# Then I do not see that the pet has been accepted or rejected for that application
# And instead I see buttons to approve or reject the pet for this specific application

  it "rejects or approves a pet on two different applications for one of the applications without removing the accept or reject buttons for the other application " do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'Pending')
    application2 = Application.create!(name: 'Bob', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'Pending')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    ApplicationPet.create!(application_id: application.id, pet_id: pet_1.id)
    ApplicationPet.create!(application_id: application2.id, pet_id: pet_1.id)

    visit "/admin/applications/#{application.id}"

    within("#pet-#{pet_1.id}") do
      expect(page).to have_content(pet_1.name)
      click_on("Reject this pet")
    end

    visit "/admin/applications/#{application2.id}"

    within("#pet-#{pet_1.id}") do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_button("Approve this pet")
      expect(page).to have_button("Reject this pet")
      expect(page).not_to have_content('Rejected')
      expect(page).not_to have_content('Approved')
    end
  end
end
