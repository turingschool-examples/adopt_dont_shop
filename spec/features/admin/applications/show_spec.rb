require 'rails_helper'

RSpec.describe 'admin applications show page' do
   before :each do
      @shelter_1 = Shelter.create!(foster_program: true, name: "ABC Shelter", city: "Nashville", rank: 1)
      @pet_1 = Pet.create!(adoptable: true, age: 3, breed: "Goldendoodle", name: "Daisy", shelter_id: @shelter_1.id)
      @pet_2 = Pet.create!(adoptable: true, age: 7, breed: "Terrier", name: "Chewie", shelter_id: @shelter_1.id)
      @pet_3 = Pet.create!(adoptable: true, age: 4, breed: "Poodle", name: "Pepper", shelter_id: @shelter_1.id)
      @pet_4 = Pet.create!(adoptable: true, age: 2, breed: "Labrador", name: "Pepperoni", shelter_id: @shelter_1.id)
      @pet_5 = Pet.create!(adoptable: true, age: 9, breed: "Husky", name: "Ms. PEANUT", shelter_id: @shelter_1.id)
      @application_1 = Application.create!(name: 'John', address: '123 Main Street', city: 'Nashville', state: 'TN', zip: 37067, description: "I want a nice dog.", status: "In Progress")
      @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      @pet_application_1 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
   end

   it "displays a button to approve apps" do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_content("Pets with pending applications:")
      # expect(page).to have_content("#{@pet_1.name}")
      # expect(page).to have_button("Approve")
      # expect(page).to have_button("Reject")

      # click_button("Approve")
      # expect(current_path).to eq("/admin/applications/#{@application_1.id}")
		# expect(page).to have_content("#{@pet_1.name} is approved for adoption.")
   end
end