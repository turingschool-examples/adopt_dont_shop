require 'rails_helper'

RSpec.describe 'Application Show Page', type: :feature do 
    describe 'visuals' do 
        it 'can show attributes of the application' do 
            shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
            pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
            pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
            pet_3 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

            application1 = Application.create!(
                name: 'Joe Exotic', 
                street_address: '3150 Horton Rd', 
                city: 'Fort Worth', 
                state: 'TX', 
                zip_code: 76119,
                description: 'I just really love animals'
            )
            application2 = Application.create!(
                name: 'Carol Baskins', 
                street_address: '12802 Easy St', 
                city: 'Tampa', 
                state: 'FL', 
                zip_code: 33625,
                description: 'I just really love animals more than that other guy'
            )

            pet_application_1 = PetApplication.create!(pet: pet_1, application: application1)
            pet_application_2 = PetApplication.create!(pet: pet_2, application: application2)
            pet_application_3 = PetApplication.create!(pet: pet_3, application: application2)

            visit "/applications/#{application1.id}"
            # save_and_open_page
            expect(page).to have_content(application1.name)
            expect(page).to have_content("Full address: 3150 Horton Rd, Fort Worth, TX 76119")
            expect(page).to have_content(application1.description)

            expect(page).to_not have_content('Carol Baskins')
            expect(page).to_not have_content("Full address: 12802 Easy St, Tampa, fL 33625")
            expect(page).to_not have_content('I just really love animals more than that other guy')

            click_link "#{pet_1.name}"
            expect(current_path).to eq("/pets/#{pet_1.id}")
            expect(page).to have_content(pet_1.name)
        end

        it 'can test for multiple pets' do 
            shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
            pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
            pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
            pet_3 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

            application1 = Application.create!(
                name: 'Joe Exotic', 
                street_address: '3150 Horton Rd', 
                city: 'Fort Worth', 
                state: 'TX', 
                zip_code: 76119,
                description: 'I just really love animals'
            )
            application2 = Application.create!(
                name: 'Carol Baskins', 
                street_address: '12802 Easy St', 
                city: 'Tampa', 
                state: 'FL', 
                zip_code: 33625,
                description: 'I just really love animals more than that other guy'
            )
            pet_application1 = PetApplication.create!(pet: pet_1, application: application1)
            pet_application2 = PetApplication.create!(pet: pet_2, application: application2)
            pet_application3 = PetApplication.create!(pet: pet_3, application: application2)

            visit "/applications/#{application2.id}"
            save_and_open_page
            expect(page).to have_content(application2.name)
            expect(page).to have_content("Full address: #{application2.street_address}, #{application2.city}, #{application2.state} #{application2.zip_code}")
            expect(page).to have_content(application2.description)

            click_link "#{pet_2.name}"
            expect(current_path).to eq("/pets/#{pet_2.id}")
            expect(page).to have_content(pet_2.name)

            visit "/applications/#{application2.id}"

            click_link "#{pet_3.name}"
            expect(current_path).to eq("/pets/#{pet_3.id}")
            expect(page).to have_content(pet_3.name)
        end 
    end
end