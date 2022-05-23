require 'rails_helper'

RSpec.describe 'admin applications show page', type: :feature do
  describe 'Approving/Rejecting a pet for adoption' do
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
      expect(page).to have_button("Reject #{pet_1.name}")
      expect(page).to have_button("Reject #{pet_2.name}")
    end

    it 'shows pet name and approval indicator on application show page after approve button is clicked' do
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

    it 'shows pet name and rejection indicator on application show page after reject button is clicked' do
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
        click_button("Reject #{pet_1.name}")

        expect(page).to have_current_path("/admin/applications/#{application1.id}")
        expect(page).to have_content("#{pet_1.name}: Rejected")
      end
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

      within "#pet#{pet_2.id}" do
        click_button("Reject #{pet_2.name}")

        expect(page).to have_current_path("/admin/applications/#{application1.id}")
        expect(page).to have_content("#{pet_2.name}: Rejected")
      end

      expect(page).to have_content("#{pet_2.name}: Rejected")
      expect(page).to have_content("#{pet_1.name}: Approved")
    end
  end

  describe 'Approved/Rejected Petso n one Application do not affect other Applications' do 
    it 'can test impartiality of individual applications for the same pet' do
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

      application2 = Application.create!(
          name: 'Carol Baskins',
          street_address: '12802 Easy St',
          city: 'Tampa',
          state: 'FL',
          zip_code: 33625,
          description: 'I just really love animals more than that other guy',
          status: 'Pending'
      )

      pet_application_1 = PetApplication.create!(pet: pet_1, application: application1)
      pet_application_2 = PetApplication.create!(pet: pet_2, application: application1)
      pet_application_3 = PetApplication.create!(pet: pet_1, application: application2)

      visit "/admin/applications/#{application1.id}"

      within "#pet#{pet_1.id}" do 
        click_button("Approve #{pet_1.name}")

        expect(current_path).to eq("/admin/applications/#{application1.id}")
        expect(page).to have_content("#{pet_1.name}: Approved")
        expect(page).to_not have_content("#{pet_2.name}: Approved")
      end

      visit "/admin/applications/#{application2.id}"

      within "#pet#{pet_1.id}" do
        expect(page).to have_button("Approve #{pet_1.name}")
        expect(page).to have_button("Reject #{pet_1.name}")
        expect(page).to_not have_content("Rejected")
        expect(page).to_not have_content("Approved")
      end 
    end 
  end
end
