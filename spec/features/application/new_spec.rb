# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit

require 'rails_helper'

RSpec.describe 'user can create new application' do
   before :each do
      @shelter_1 = Shelter.create!(foster_program: true, name: "ABC Shelter", city: "Nashville", rank: 1)

      @pet_1 = Pet.create!(adoptable: true, age: 3, breed: "Goldendoodle", name: "Daisy", shelter_id: @shelter_1.id)
      @pet_2 = Pet.create!(adoptable: true, age: 7, breed: "Terrier", name: "Chewie", shelter_id: @shelter_1.id)

      @application_1 = Application.create!(name: 'John', address: '123 Main Street', city: 'Nashville', state: 'TN', zip: 37067, description: "I want a nice dog.", status: "In Progress")

      @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      @pet_application_1 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
   end

   it "can redirect the user from pet index to /applications/new" do
       visit "/pets"
      expect(page).to have_content("Start an Application")

      click_on("Start an Application")
      expect(current_path).to eq("/applications/new")
   end

   it "has a form that creates a new application" do
      visit "/applications/new"

      fill_in "name", with: "John"
      fill_in "address", with: "123 Main Street"
      fill_in "city", with: "Nashville"
      fill_in "state", with: "TN"
      fill_in "zip", with: 37067
      fill_in "description", with: "I love dogs."

      click_on("Submit")

      expect(page).to have_content("John")
      expect(page).to have_content("123 Main Street")
      expect(page).to have_content("Nashville")
      expect(page).to have_content("TN")
      expect(page).to have_content(37067)
      expect(page).to have_content("I love dogs.")
      expect(page).to have_content("In Progress")
   end
end
