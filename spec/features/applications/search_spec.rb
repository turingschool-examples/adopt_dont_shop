require 'rails_helper'

RSpec.describe 'Search' do 
  describe 'when I search for a pet on the application show page' do
    it 'shows results based on partial match' do 
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      application = Application.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "In Progress")

      visit "/applications/#{application.id}"

      fill_in :search, with: "Ba"
      click_button("Search")
  
      within "#Search_Pets" do
        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_2.name)
        expect(page).to_not have_content(pet_3.name)
      end
    end 

    it 'can search for case insensitive matches for pet names' do 
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      application = Application.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "In Progress")

      visit "/applications/#{application.id}"

      fill_in :search, with: "ba"
      click_button("Search")

      within "#Search_Pets" do
        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_2.name)
        expect(page).to_not have_content(pet_3.name)
      end
    end 
  end 
end 