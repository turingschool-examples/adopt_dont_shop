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
      PetApplication.create!(pet: @pet_1, application: @application_1)
      PetApplication.create!(pet: @pet_2, application: @application_1)

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
   end

   it 'has links to the pets show pages' do
     visit "/applications/#{@application_1.id}"

     click_on("Mr. Pirate")
     expect(current_path).to eq("/pets/#{@pet_1.id}")
     expect(page).to have_content(@pet_1.name)
     expect(page).to have_content(@pet_1.age)
     expect(page).not_to have_content(@pet_2.name)
   end

   it 'when application is pending you can add pets' do
     visit "/applications/#{@application_2.id}"
     save_and_open_page
     visit "/applications/#{@application_1.id}"
     save_and_open_page
     # expect(page).to have_content("Add a Pet to this Application")
   end

   it 'allows for a search of pets by name' do

     visit "/applications/#{@application_1.id}"

     # expect(page).to have_content("Add a Pet to this Application")

     fill_in(:pet_name, with: "Mr Pirate")
     click_on("Search")

     expect(current_path).to eq("/applications/#{@application_1.id}")
     expect(page).to have_content(@pet_1.name)
   end
  end
end
