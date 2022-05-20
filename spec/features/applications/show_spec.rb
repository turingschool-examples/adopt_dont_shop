require 'rails_helper'

RSpec.describe 'Application Show Page', type: :feature do 
    describe 'visuals' do 
        it 'can show attributes of the application' do 
            applicant1 = Application.create!(
                name: 'Joe Exotic', 
                street_address: '3150 Horton Rd', 
                city: 'Fort Worth', 
                state: 'TX', 
                zip_code: 76119,
                description: 'I just really love animals'
            )
            applicant2 = Application.create!(
                name: 'Carol Baskins', 
                street_address: '12802 Easy St', 
                city: 'Tampa', 
                state: 'FL', 
                zip_code: 33625,
                description: 'I just really love animals more than that other guy'
            )

            visit "/applications/#{applicant1.id}"
            # save_and_open_page
            expect(page).to have_content('Joe Exotic')
            expect(page).to have_content("Full address: 3150 Horton Rd, Fort Worth, TX 76119")
            expect(page).to have_content('I just really love animals')
            

            expect(page).to_not have_content('Carol Baskins')
            expect(page).to_not have_content("Full address: 12802 Easy St, Tampa, fL 33625")
            expect(page).to_not have_content('I just really love animals more than that other guy')
        end
    end
end