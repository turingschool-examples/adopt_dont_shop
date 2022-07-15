require 'rails_helper'

RSpec.describe 'Application Show Page' do
  describe 'when i visit the applications show page' do
    it 'then i can see the name, full address, description, names of pets, and application status of the specified application' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "In Progress")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id, application_id: application.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id, application_id: application.id)
      
      
      visit "/applications/#{application.id}"
      
      expect(page).to have_content("Jerry Rice")
      expect(page).to have_content("123 Main Street")
      expect(page).to have_content("Honolulu")
      expect(page).to have_content("HI")
      expect(page).to have_content("We love doggos!")
      expect(page).to have_link("Spot")
      expect(page).to have_link("Frenchie")
      expect(page).to have_content("In Progress")
      
      
    end
  end
end