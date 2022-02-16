require 'rails_helper'

RSpec.describe 'The admin shelters show page' do 
    before :each do 
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora', foster_program: false, rank: 9, street_address: "214 w placid", state: "CO", zipcode: "82743")
        @shelter_2 = Shelter.create(name: 'Englewood shelter', city: 'Englewood', foster_program: false, rank: 9, street_address: "7325 w Hampden", state: "CO", zipcode: "80239")
        @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 12, adoptable: true)
        @pet_3 = @shelter_1.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    end 
    it 'shows the shelters name and full address' do 
        visit "/admin/shelters/#{@shelter_1.id}"
        expect(page).to have_content("Admin Shelter Show Page")
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_1.city)
        expect(page).to have_content(@shelter_1.street_address)
        expect(page).to have_content(@shelter_1.state)
        expect(page).to have_content(@shelter_1.zipcode)
        @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 2, adoptable: false)
        @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 8, adoptable: true)
        @pet_3 = @shelter_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
        @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 12, adoptable: true)
    end 

    it 'has a section for statistics where the average age of all adoptable pets for that shelter is visible' do 
        visit "/admin/shelters/#{@shelter_1.id}"
        within(".statistics") do 
            expect(page).to have_content(@shelter_1.adoptable_pets_avg_age)
        end 
    end 
end 