require 'rails_helper'

RSpec.describe "The Admin Shelter Index" do
  describe "User Story 11" do
    it "Shows the visitor a button to approve the application for that specific pet, For every pet that the application is for" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      applicant = Application.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )

      ApplicationPet.create!(application: applicant, pet: pet_1)
      ApplicationPet.create!(application: applicant, pet: pet_2)

      visit "/admin/applications/#{applicant.id}"

      within "#pending-#{pet_1.id}" do
       expect(page).to have_button("Approve Adoption") 
      end

      within "#pending-#{pet_2.id}" do
        expect(page).to have_button("Approve Adoption") 
      end
    end

    it "redirects back to application show page and next to the pet that the user approved,the user no longer sees a button to approve the already approved pet" do

      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      applicant = Application.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )

      ApplicationPet.create!(application: applicant, pet: pet_1)
      ApplicationPet.create!(application: applicant, pet: pet_2)

      visit "/admin/applications/#{applicant.id}"

      within "#pending-#{pet_1.id}" do
        click_button("Approve Adoption")
        expect(current_path).to eq("/admin/applications/#{applicant.id}")
        expect(page).to_not have_button("Approve Adoption")
        expect(page).to have_content("Has been Approved")
      end
    end
  end
end