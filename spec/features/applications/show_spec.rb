require 'rails_helper'

RSpec.describe 'Application Show Page' do
  describe 'when visiting the page' do
    before :each do
      @application_1 = Application.create!(
        name: 'Anita Barker',
        street_address: '2468 Park Blvd.',
        city: 'Denver',
        state: 'CO',
        zipcode: '80202',
        # description: 'none',
        # status: 'pending'
      )
      @application_2 = Application.create!(
        name: 'Bob Barker',
        street_address: '1357 20th st.',
        city: 'Golden',
        state: 'CO',
        zipcode: '80209',
        # description: 'na',
        # status: 'In Progress'
      )

      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      @pet_4 = @shelter_1.pets.create(name: 'Purrdy', breed: 'persian', age: 6, adoptable: true)
    end

    it 'contains the name, address, description of the applicant, and application status' do

     visit "/applications/#{@application_1.id}"

     expect(page).to have_content(@application_1.name)
     expect(page).to have_content(@application_1.street_address)
     expect(page).to have_content(@application_1.city)
     expect(page).to have_content(@application_1.state)
     expect(page).to have_content(@application_1.zipcode)
     # expect(page).to have_content(@pet_1.name)
     # expect(page).to have_content(@pet_2.name)
     expect(page).to have_content(@application_1.description)
     expect(page).to have_content(@application_1.status)
     expect(page).not_to have_content(@application_2.name)
     expect(page).not_to have_content(@application_2.street_address)
   end

   it 'has links to the pets show pages' do
     PetApplication.create!(pet: @pet_1, application: @application_1)

     visit "/applications/#{@application_1.id}"

     click_on("Mr. Pirate")
     expect(current_path).to eq("/pets/#{@pet_1.id}")
     expect(page).to have_content(@pet_1.name)
     expect(page).to have_content(@pet_1.age)
     expect(page).not_to have_content(@pet_2.name)
   end

   it 'when application is pending you can add pets' do
     PetApplication.create!(pet: @pet_1, application: @application_1)
     PetApplication.create!(pet: @pet_2, application: @application_1)
     visit "/applications/#{@application_2.id}"
     expect(page).to have_content("Add Pet to Application")
     # save_and_open_page
     visit "/applications/#{@application_1.id}"
     # save_and_open_page
     expect(page).to have_content("Add Pet to Application")
   end

   it 'allows for a search of pets by name' do

     visit "/applications/#{@application_1.id}"

     expect(page).to have_content("Add Pet to Application")

     fill_in(:pet_name, with: "Mr. Pirate")
     click_on("Search")

     expect(current_path).to eq("/applications/#{@application_1.id}")
     expect(page).to have_content(@pet_1.name)
     expect(page).not_to have_content(@pet_2.name)
   end

   it 'searches for pets with partial name' do
     @pet_5 = @shelter_1.pets.create(name: 'Junipurr', breed: 'maine coon', age: 8, adoptable: true)
     @pet_6 = @shelter_1.pets.create(name: 'Sir purge', breed: 'golden retriever', age: 5, adoptable: true)

     visit "/applications/#{@application_1.id}"
     fill_in(:pet_name, with: "pur")
     click_on("Search")
     expect(current_path).to eq("/applications/#{@application_1.id}")
     expect(page).to have_content(@pet_5.name)
     expect(page).to have_content(@pet_6.name)
     expect(page).to have_content(@pet_4.name)
     expect(page).not_to have_content(@pet_1.name)
   end

   it 'can add pets to the application with a button' do
     visit "applications/#{@application_1.id}"
     fill_in(:pet_name, with: "Mr. Pirate")
     click_on("Search")

     within ".pet-#{@pet_1.id}" do
       click_button "Adopt this Pet"
     end
     expect(current_path).to eq("/applications/#{@application_1.id}")
     expect(page).to have_link(@pet_1.name)
     expect(page).not_to have_content(@pet_2.name)
   end

   it 'can submit an application once pets are added' do
     PetApplication.create!(pet: @pet_1, application: @application_1)
     PetApplication.create!(pet: @pet_2, application: @application_1)

     visit "/applications/#{@application_1.id}"
     expect(page).to have_content("Submit Application")
     fill_in(:description, with: "Because I like animals")
     click_on "Submit"
     expect(current_path).to eq("/applications/#{@application_1.id}")
     expect(page).to have_content("Pending")
     updated_app = Application.find(@application_1.id)
     expect(updated_app.id).to eq(@application_1.id)
     expect(updated_app.status).to eq("Pending")
     expect(updated_app.description).to eq("Because I like animals")
     expect(page).not_to have_content("Add Pet to Application")
   end

   it 'can not be submitted if there are no pets on the application' do
     visit "/applications/#{@application_1.id}"

     expect(@application_1.pets).to eq([])
     expect(page).not_to have_content("Submit Application")
     expect(page).not_to have_button("Submit")
   end
 end
end
