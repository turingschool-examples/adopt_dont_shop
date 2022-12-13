require 'rails_helper'

RSpec.describe 'admin shelters index page' do 
  describe 'when I visit the admin shelters index' do
    before(:each) do
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
      @application_1 = @pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
      @application_2 = @pet_2.applications.create!(name: 'Jimbo', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Jimbo wants a buddy", status: "Pending")
      @application_3 = @pet_3.applications.create!(name: 'Bill', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Bill wants a buddy", status: "In Progress")
    end 

    it 'displays all shelters in reverse alphabetical order by name' do 
      visit '/admin/shelters'

      within "#All_Shelters" do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_2.name)
        expect(page).to have_content(@shelter_3.name)

        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
      end
    end 

    it 'has a section for shelters with pending applications' do
      visit '/admin/shelters'

      expect(page).to have_content("Shelters With Pending Applications:")

      within "#Pending" do
        expect(page).to have_content(@shelter_1.name)
      end
    end
  end 
end 