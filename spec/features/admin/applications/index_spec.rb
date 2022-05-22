require 'rails_helper'

RSpec.describe "Admin Shelter Show Page", type: :feature do
    describe "ability to approve or reject a pet for an application" do
        before :each do
            @dumb_friends = Shelter.create!(name: 'Denver Dumb Friends League', city: 'Denver', rank: 4, foster_program: true)
            @boulder_county = Shelter.create!(name: 'Boulder County Shelter', city: 'Boulder', rank: 7, foster_program: true)
            @application_1 = Application.create!(name: 'Antonio', street_address: '1234 Drury Lane', city: 'San Francisco', state: 'CA', zip_code: '94016', description: 'God', status: 0)
            @application_2 = Application.create!(name: 'Casey', street_address: '1564 Pearl Street', city: 'Boulder', state: 'C0', zip_code: '80037', description: 'Allah', status: 0)
            @rajah = @dumb_friends.pets.create!(name: 'Rajah', breed: 'cat', age: 5, adoptable: false)
            @stacks = @dumb_friends.pets.create!(name: 'Stacks', breed: 'german shepherd', age: 10, adoptable: true)
            @flaubert = @boulder_county.pets.create!(name: 'Flaubert', breed: 'terrier', age: 2, adoptable: true)
            @pavel = @boulder_county.pets.create!(name: 'Pavel', breed: 'cat', age: 4, adoptable: true)
            ApplicationPet.create!(application: @application_1, pet: @rajah)
            ApplicationPet.create!(application: @application_1, pet: @stacks)
            ApplicationPet.create!(application: @application_1, pet: @flaubert)
            ApplicationPet.create!(application: @application_2, pet: @pavel)
        end
        it "has a link to each admin application show page" do
            visit "/admin/applications"
            click_link "Visit #{@application_1.name}'s Application"
            expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        end
    end
end