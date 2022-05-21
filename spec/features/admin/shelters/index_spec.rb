require 'rails_helper'

RSpec.describe 'Admin Shelter Index Page' do
    describe 'Admin Shelters Index' do
        before :each do
            dumb_friends = Shelter.create!(name: 'Denver Dumb Friends League', city: 'Denver', rank: 4, foster_program: true)
            boulder_county = Shelter.create!(name: 'Boulder County Shelter', city: 'Boulder', rank: 7, foster_program: true)
            humane_society = Shelter.create!(name: 'Humane Society', city: 'Denver', rank: 12, foster_program: false)
            max_fund = Shelter.create!(name: 'MaxFund Shelter', city: 'Oakland', rank: 2, foster_program: true)
        end

        it 'lists all shelters in reverse alphbetical' do
            visit "/admin/shelters"
            expect("MaxFund Shelter").to appear_before("Humane Society")
            expect("Humane Society").to appear_before("Denver Dumb Friends League")
            expect("Denver Dumb Friends League").to appear_before("Boulder County Shelter")
        end

        it "has a sections for shelters with pending applications" do
            visit '/admin/shelters'
            within "#pending-shelters" do
                expect(page).to have_content("Humane Society") 
                expect(page).to have_content("Boulder County Shelter") 
                expect(page).to_not have_content("Denver Dumb Friends League") 
                expect(page).to_not have_content("MaxFund Shelter") 
            end
        end
        
    end
end