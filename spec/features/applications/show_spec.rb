require 'rails_helper'

RSpec.describe 'Applications show page' do
  describe 'when I visit /applcations/:id' do
    it 'shows all of the application information' do
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      application = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
      
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zipcode)
      expect(page).to have_content(application.description)
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(application.status)
    end

    it 'has links to the pets show pages' do 
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      pet_2 = shelter.pets.create!(name: "Sammy", age: 5, breed: 'lab', adoptable: true)
      application_1 = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
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

    it 'has a section to add pets to the application by name' do
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      pet_2 = shelter.pets.create!(name: "Sammy", age: 5, breed: 'lab', adoptable: true)
      application_1 = Application.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "In Progress")

      visit "/applications/#{application_1.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(application_1.status).to eq("In Progress")

      fill_in :search, with: pet_2.name
      click_button "Search"
  
      expect(current_path).to eq("/applications/#{application_1.id}")
      
      within "#Search_Pets" do
        expect(page).to have_content(pet_2.name)
      end
    end 

    it 'can add a pet to the application' do 
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      pet_2 = shelter.pets.create!(name: "Sammy", age: 5, breed: 'lab', adoptable: true)
      application_1 = Application.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "In Progress")
    
      visit "/applications/#{application_1.id}"
     
      fill_in :search, with: pet_2.name
      click_button "Search"

      expect(current_path).to eq("/applications/#{application_1.id}")
      
      click_on "Adopt this Pet"
      expect(current_path).to eq("/applications/#{application_1.id}")
      expect(pet_2.name).to appear_before(application_1.status)
    end 
  end
end