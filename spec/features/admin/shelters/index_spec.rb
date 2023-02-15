require 'rails_helper'

RSpec.describe "The Admin Shelter Index" do
  describe "User Story 10" do
    it " Displays to the user all shelters in the system listed in reverse alphabetical order " do
      shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 8)
      shelter_3 = Shelter.create!(name: 'Vail shelter', city: 'Vail, CO', foster_program: false, rank: 7)

      visit "/admin/shelters"

      expect("#{shelter_2.name}").to appear_before("#{shelter_1.name}")
    end
  end

  describe "User Story 11" do
    it "has a section for Shelters with Pending Application" do
      shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 8)
      shelter_3 = Shelter.create!(name: 'Vail shelter', city: 'Vail, CO', foster_program: false, rank: 7)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_1.id)
      applicant_1 = Application.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )
      ApplicationPet.create!(application: applicant_1, pet: pet_1)
      visit "/admin/shelters"

      expect(page).to have_content("Shelters with Pending Applications")
    end

    it "has the names of shelters with pending applications" do
      shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 8)
      shelter_3 = Shelter.create!(name: 'Vail shelter', city: 'Vail, CO', foster_program: false, rank: 7)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter_1.id)
      applicant_1 = Application.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "Pending"
      )
      ApplicationPet.create!(application: applicant_1, pet: pet_1)

      visit "/admin/shelters"
  
      within('div#pending') do
        expect(page).to have_content('Aurora shelter')
      end
    end
  end
end