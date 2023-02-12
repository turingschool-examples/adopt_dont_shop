# As a visitor
# When I visit an applications show page
# Then I can see the following:

# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe 'the application show' do
  describe "User Story 2" do
    before(:each) do
      ApplicationPet.destroy_all
      Pet.destroy_all
      Shelter.destroy_all
      Application.destroy_all
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @applicant_1 = @pet_1.applications.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )
    end
    it "shows the visitor the applicant and all of it's attributes" do
      visit "/applications/#{@applicant_1.id}"
      expect(current_path).to eq("/applications/#{@applicant_1.id}")
      expect(page).to have_content(@applicant_1.name)
      expect(page).to have_content(@applicant_1.street_address)
      expect(page).to have_content(@applicant_1.city)
      expect(page).to have_content(@applicant_1.state)
      expect(page).to have_content(@applicant_1.zip_code)
      expect(page).to have_content(@applicant_1.reason_for_adoption)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@applicant_1.status)
      
      expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
    end
  end
  
  describe "User Story 4" do
    before(:each) do
      ApplicationPet.destroy_all
      Pet.destroy_all
      Shelter.destroy_all
      Application.destroy_all
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @applicant_1 = @pet.applications.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )
    end

    it "displays a section on the show page to 'Add a Pet to this Application'" do
      visit "/applications/#{@applicant_1.id}"

      expect(page).to have_content('Add a Pet to this Application')
    end

    it "has an input where the visitor can search for Pets by name" do
      visit "/applications/#{@applicant_1.id}"

      expect(page).to have_button("Search")
    end

    it "When the visitor fills in this field with a Pet's name, And clicks submit, Then they are taken back to the application show page" do
      visit "/applications/#{@applicant_1.id}"

      fill_in("Search", with: "Mr")

      click_button("Search")

      expect(current_path).to eq("/applications/#{@applicant_1.id}")
    end

    it "Shows the visitor any Pet whose name matches my search under the search bar" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      
      visit "/applications/#{@applicant_1.id}"

      fill_in 'Search', with: "Ba"
      click_on("Search")

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)
    end
  end

end