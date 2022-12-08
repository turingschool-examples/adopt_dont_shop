require 'rails_helper'

RSpec.describe 'Applications show page' do
  describe 'when I visit /applcations/:id' do
    it 'shows all of the application information' do
      application = Application.create!(app_name: 'Billy Bob', address: "54984 Bulldog Rd Salem, OR 97301", description: "Billy Bob wants a buddy", pet_names: "Bobby", status: "Pending")
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.app_name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content(application.status)
    end

    it 'has links to the pets show pages' do 
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      application = pet_1.applications.create!(app_name: 'Billy Bob', address: "54984 Bulldog Rd Salem, OR 97301", description: "Billy Bob wants a buddy", pet_names: "Bobby", status: "Pending")
     
      visit "/applications/#{application.id}"

      click_link("#{pet_1.name}")

      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_content("#{pet_1.name}")

     end
  end
end