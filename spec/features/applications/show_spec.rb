require 'rails_helper'

RSpec.describe 'Applications show page' do
  describe 'when I visit /applcations/:id' do
    it 'shows all of the application information' do
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      application = pet_1.applications.create!(app_name: 'Billy Bob', address: "54984 Bulldog Rd Salem, OR 97301", description: "Billy Bob wants a buddy", status: "Pending")
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.app_name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(application.status)
    end

    it 'has links to the pets show pages' do 
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      pet_2 = shelter.pets.create!(name: "Sammy", age: 5, breed: 'lab', adoptable: true)
      application_1 = pet_1.applications.create!(app_name: 'Billy Bob', address: "54984 Bulldog Rd Salem, OR 97301", description: "Billy Bob wants a buddy", status: "Pending")
      ApplicationPet.create!(pet: pet_2, application: application_1)

      visit "/applications/#{application_1.id}"

      click_link("#{pet_1.name}")

      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_content("#{pet_1.name}")

      visit "/applications/#{application_1.id}"

      click_link("#{pet_2.name}")

      expect(current_path).to eq("/pets/#{pet_2.id}")
      expect(page).to have_content("#{pet_2.name}")
     end
  end
end