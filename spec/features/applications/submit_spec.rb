require "rails_helper"

RSpec.describe 'Applications Submit' do
  describe 'when I visit /applcations/:id' do
    describe'and I have added pets to my application' do
      it 'shows a section to submit application' do
        shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
        pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
        application = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", status: "In Progress")
        visit "/applications/#{application.id}"
        
        expect(application.status).to eq("In Progress")
        fill_in :description, with: 'I love dogs'
        click_on("Submit Application")

        expect(current_path).to eq("/applications/#{application.id}")
        expect(page).to have_content("Pending")  
        expect(page).to have_content('Pet(s) to be Adopted: Bobby')
        expect(page).to_not have_content("Add a Pet to this Application")
      end
    end
  end
end
