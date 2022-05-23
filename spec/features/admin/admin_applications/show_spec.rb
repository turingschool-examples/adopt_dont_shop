require 'rails_helper'

RSpec.describe 'admin applications show page', type: :feature do
  describe 'Approving a pet for adoption' do
    it 'Shows a button for each pet needing approval/rejection' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

      application1 = Application.create!(
          name: 'Waldo Werziat',
          street_address: '-1 Bermuda trgl',
          city: 'Atlantis',
          state: 'Confusion',
          zip_code: 42070,
          description: "I'm really lonely.",
          status: 'Pending'
      )
      pet_application_1 = PetApplication.create!(pet: pet_1, application: application1)
      pet_application_2 = PetApplication.create!(pet: pet_2, application: application1)

      visit "/admin/applications/#{application1.id}"

      expect(page).to have_button("Approve #{pet_1.name}")
      expect(page).to have_button("Approve #{pet_2.name}")
    end

    it 'shows pet name and aproval indicator on application show page after button clicked' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

      application1 = Application.create!(
          name: 'Waldo Werziat',
          street_address: '-1 Bermuda trgl',
          city: 'Atlantis',
          state: 'Confusion',
          zip_code: 42070,
          description: "I'm really lonely.",
          status: 'Pending'
      )
      pet_application_1 = PetApplication.create!(pet: pet_1, application: application1)
      pet_application_2 = PetApplication.create!(pet: pet_2, application: application1)

      visit "/admin/applications/#{application1.id}"

      within "#pet#{pet_1.id}" do
        click_button("Approve #{pet_1.name}")

        expect(page).to have_current_path("/admin/applications/#{application1.id}")
        expect(page).to have_content("#{pet_1.name}: Approved")
      end
    end
  end
end
