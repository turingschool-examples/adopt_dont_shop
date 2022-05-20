require 'rails_helper'

RSpec.describe 'Application Show Page', type: :feature do 
    describe 'visuals' do 
        it 'can show attributes of the application' do 
            shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
            pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
            pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
            pet_3 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

            applicant1 = Application.create!(
                name: 'Joe Exotic', 
                street_address: '3150 Horton Rd', 
                city: 'Fort Worth', 
                state: 'TX', 
                zip_code: 76119,
                description: 'I just really love animals',
                pet_id: pet_1.id
            )
            # applicant2 = Application.create!(
            #     name: 'Carol Baskins', 
            #     street_address: '12802 Easy St', 
            #     city: 'Tampa', 
            #     state: 'FL', 
            #     zip_code: 33625,
            #     description: 'I just really love animals more than that other guy'
            # )

            visit "/applications/#{applicant1.id}"
            # save_and_open_page
            expect(page).to have_content('Joe Exotic')
            expect(page).to have_content("Full address: 3150 Horton Rd, Fort Worth, TX 76119")
            expect(page).to have_content('I just really love animals')

            click_link "#{pet_1.name}"
            expect(current_page).to eq("/pets/#{pet_1.id}")

            expect(page).to_not have_content('Carol Baskins')
            expect(page).to_not have_content("Full address: 12802 Easy St, Tampa, fL 33625")
            expect(page).to_not have_content('I just really love animals more than that other guy')
        end
    end
end