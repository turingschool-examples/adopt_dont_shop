require 'rails_helper'

RSpec.describe 'admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    
    @shelter_1.pets.create!(name: 'Scooby', breed: 'Great Dane', age: 2, adoptable: true)
    @shelter_1.pets.create!(name: 'Scrappy', breed: 'Great Dane', age: 1, adoptable: true)
    @shelter_3.pets.create!(name: 'Spot', breed: 'Dalmation', age: 3, adoptable: true)
    # @shelter_4.pets.create!(name: 'Garfield', breed: 'Tabby', age: 7, adoptable: true)

    @application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203')
    @application_2 = Application.create!(name: 'Cruela De Ville', street_address: '666 Dalmation Way', city: 'Highland Ranch', state: 'Colorado', zip_code: '80234')
    @application_3 = Application.create!(name: 'Sarah McGlachlan', street_address: '444 Arms of an Angel', city: 'Aspen', state: 'Colorado', zip_code: '80444')
    
    @pet_1 = @application_1.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = @application_1.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
    @pet_3 = @application_2.pets.create!(name: 'Spot', age: 3, breed: 'Dalmation', adoptable: true, shelter_id: @shelter_3.id)
    # @pet_4 = @application_3.pets.create!(name: 'Garfield', age: 7, breed: 'Tabby', adoptable: true, shelter_id: @shelter_2.id)
    
  end

  describe 'When I visit the admin shelter index (/admin/shelters)' do
    it 'Then I see all Shelters in the system listed in reverse alphabetical order by name' do
      visit "/admin/shelters"
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end

    it "I see a section for 'Shelters with Pending Applications, see names of Shelters with pending applications" do
      visit "/admin/shelters"
      expect(page).to have_content("Shelters with Pending Applications")
      within("#pending_shelters") do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_3.name)
        expect(page).to_not have_content(@shelter_2.name)
      end
    end
  end

 
end