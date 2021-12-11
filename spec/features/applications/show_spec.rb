require 'rails_helper'

RSpec.describe 'Application show page' do 

    before(:each) do

        @helping_hounds = Shelter.create!(name: 'Helping Hounds', city: 'Syracuse, NY', foster_program: false, rank: 2)

        @max = Pet.create!(name: 'Max', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: @helping_hounds.id)

        @josie = Pet.create!(name: 'Josie', age: 5, breed: 'Great Pyrenees', adoptable: true, shelter_id: @helping_hounds.id)

        @rambo = Pet.create!(name: 'Rambo', age: 1, breed: 'Chihuahua', adoptable: true, shelter_id: @helping_hounds.id)

        @application1 = @max.applications.create!(name: "John Doe", address: "123 Main Street", city: "Brooklyn", state: "NY", zip: "11205", reason: "I grew up with large dogs and want to bring the same joy into my home.", status: "in progress")

        @application1.pets << @josie
        
        @application2 = @josie.applications.create!(name: "Jeff Daniels", address: "456 Orderly Way", city: "Seattle", state: "WA", zip: "65412", reason: "I want to help as many innocent animals as I can.", status: "pending")

    end

    it 'displays applicant information for an application' do
        visit "/applications/#{@application1.id}"

        expect(page).to have_content(@application1.name)
        expect(page).to have_content(@application1.address)
        expect(page).to have_content(@application1.reason)
        expect(page).to have_content(@josie.name)
        expect(page).to have_content(@max.name)
        expect(page).to have_content(@application1.status)

        click_link "Max"
        expect(current_path).to eq("/pets/#{@max.id}")

        expect(page).to_not have_content(@application2.name)
        expect(page).to_not have_content(@application2.address)
        expect(page).to_not have_content(@application2.reason)
        expect(page).to_not have_content(@rambo.name)
        expect(page).to_not have_content(@application2.status)

    end
end