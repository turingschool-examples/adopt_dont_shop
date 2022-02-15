require 'rails_helper'

RSpec.describe 'The admin shelters show page' do 
    before :each do 
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora', foster_program: false, rank: 9, street_address: "214 w placid", state: "CO", zipcode: "82743")
        @shelter_2 = Shelter.create(name: 'Englewood shelter', city: 'Englewood', foster_program: false, rank: 9, street_address: "7325 w Hampden", state: "CO", zipcode: "80239")
    end 
    it 'shows the shelters name and full address' do 
        visit "/admin/shelters/#{@shelter_1.id}"
        expect(page).to have_content("Admin Shelter Show Page")
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_1.city)
        expect(page).to have_content(@shelter_1.street_address)
        expect(page).to have_content(@shelter_1.state)
        expect(page).to have_content(@shelter_1.zipcode)
    end 
end 