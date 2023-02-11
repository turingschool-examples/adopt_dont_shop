require 'rails_helper'

RSpec.describe "Applications Update" do 
  describe 'when visiting the applications show page' do 
    shelter1 = Shelter.create!(foster_program: true, name: 'Pet Friends', city: "Denver", rank: 3)
    app1 = Application.create!(name: 'Matt Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
    app2 = Application.create!(name: 'Jake Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
    pet1 = Pet.create!(adoptable: true, age: 46, breed: 'snapping', name: 'Shelly', shelter_id: shelter1.id, )
    pet2 = Pet.create!(adoptable: true, age: 2, breed: 'husky', name: 'Benedict McBark', shelter_id: shelter1.id,)
    petapplication1 = PetApplication.create!(pet_id: pet1.id, application_id: app1.id)
    
    it 'has a section to submit application' do 
      visit "/applications/#{app2.id}"

      expect(page).to have_content("Add pet to this Application")
  
      fill_in("Add pet to this Application", with: "Benedict McBark")
      click_button "Search"

      petapplication2 = PetApplication.create!(pet_id: pet2.id, application_id: app2.id)

      expect(current_path).to eq("/applications/#{app2.id}")
      expect(page).to have_content("Benedict McBark")
      save_and_open_page
      click_button("Adopt this pet")
      expect(page).to have_content("Submit Application")

      fill_in("Submit Application", with: "I would be a good dog dad")
      click_button("Submit")

      expect(current_path).to eq("/applications/#{app2.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content(pet2.name)

    end
  end
end