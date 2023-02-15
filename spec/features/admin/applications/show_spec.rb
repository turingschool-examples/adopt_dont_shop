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
      end

      expect(current_path).to eq("/admin/applications/#{applicant.id}")

      within "#pending-#{pet_1.id}" do
        expect(page).to_not have_button("Approve Adoption", visible: :hidden)
        expect(page).to have_content("The Application for #{pet_1.name} has been APPROVED!!!")
      end
    end

    it "redirects back to application show page and next to the pet that the user rejected,the user no longer sees a button to reject the already rejected pet" do
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
        click_button("Reject Adoption")
      end

      expect(current_path).to eq("/admin/applications/#{applicant.id}")

      within "#pending-#{pet_1.id}" do
        expect(page).to_not have_button("Reject Adoption", visible: :hidden)
        expect(page).to have_content("The Application for #{pet_1.name} has been REJECTED!!!")
      end
    end
  end

  describe "User Story 14" do
    it "Approval or rejection does not affect pet status on another application" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      applicant_1 = Application.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )
      applicant_2 = Application.create!(name: 'Steve Steverson', 
        street_address: '1234 Steve ave.', 
        city: 'Steve', 
        state: 'CO',
        zip_code: 12345, 
        reason_for_adoption: "I am Steve",
        status: "In Progress"
      )

      ApplicationPet.create!(application: applicant_1, pet: pet_1)
      ApplicationPet.create!(application: applicant_2, pet: pet_1)

      visit "/admin/applications/#{applicant_1.id}"

      within "#pending-#{pet_1.id}" do
        click_button("Reject Adoption")
      end

      visit "/admin/applications/#{applicant_2.id}"

      within "#pending-#{pet_1.id}" do
        expect(page).to have_button("Reject Adoption")
        expect(page).to have_button("Approve Adoption")
      end
    end
  end
end