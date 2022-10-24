require 'rails_helper'

RSpec.describe 'the applications show page' do 
  describe 'when a visitor visits the applications show page' do 
    it 'shows the applicant and all its attributes' do 
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230)
      application_2 = Application.create!(name: "Joe", street_address: "1234 Park Rd", city: "Aurora", state: "CO", zip_code: 80206)
      PetApplication.create(pet: pet_1, application: application_1)
      PetApplication.create(pet: pet_2, application: application_1)

      visit "/applications/#{application_1.id}"
      # visit "/applications"
      within("#application_show") do 
        expect(page).to have_content("Street Address: #{application_1.street_address}")
        expect(page).to have_content("#{application_1.name}")
        expect(page).to have_content("City: #{application_1.city}")
        expect(page).to have_content("State: #{application_1.state}")
        expect(page).to have_content("Zip Code: #{application_1.zip_code}")
        expect(page).to_not have_content("City: #{application_2.city}")
      end

      expect(page).to have_content(application_1.status)
      expect(page).to have_content(application_1.pets.name)
      # save_and_open_page
    end

    describe 'application show page pet search' do
      it 'has a search input where users can search pets by name when the application is not submitted' do
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
        pet_2 = shelter.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
        application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "In-Progress", description: "I love cats")

        visit "/applications/#{application_1.id}"
        # visit "/applications/create/?status=In-Progress"

        expect(page).to have_content("Add a Pet to this Application")
         fill_in 'pet_search', with: 'Lobster'
         click_button 'Search'

         expect(page).to have_content("Lobster")
         expect(page).not_to have_content("Lucille Bald")
        
      end
      it 'has does not have a search bar when the application has been submitted' do
        application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "Pending", description: "I love cats")

        visit "/applications/#{application_1.id}"

        expect(page).to_not have_content("Add a Pet to this Application")
      end
      it 'has a case-insensitive search' do
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
        application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "In-Progress", description: "I love cats")
        new_application_id = Application.last.id 

        visit "/applications/#{new_application_id}"

         fill_in 'pet_search', with: 'lucille bAld'
         click_button 'Search'

         expect(page).to have_content("Lucille Bald")
      end
      it 'has a partial search' do
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
        pet_2 = shelter.pets.create!(adoptable: true, age: 2, breed: 'american shorthair', name: 'Lucky')
        pet_3 = shelter.pets.create!(adoptable: true, age: 5, breed: 'labrador', name: 'Ted')
        application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "In-Progress", description: "I love cats")

        visit "/applications/#{application_1.id}"

         fill_in 'pet_search', with: 'luc'
         click_button 'Search'

         expect(page).to have_content("Lucille Bald")
         expect(page).to have_content("Lucky")
         expect(page).not_to have_content("Ted")
      end
    end

    describe 'adding a pet to an application' do 
      describe 'after searching for a pet by name a user can click a button to add pet to app' do 
        it 'button adds the pet and takes user back to applciation show page where the pet is listed' do 
          shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
          pet_1 = shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
          pet_2 = shelter.pets.create!(adoptable: true, age: 2, breed: 'american shorthair', name: 'Lucky')
          pet_3 = shelter.pets.create!(adoptable: true, age: 5, breed: 'labrador', name: 'Ted')
          application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "In-Progress", description: "I love cats")

          visit "/applications/#{application_1.id}"
          expect(page).not_to have_content("Applying For: Lucille Bald")

          fill_in 'pet_search', with: 'luc'
          click_button 'Search'

          within("#search_pets") do 
            expect(page).to have_content("Lucille Bald")
          end
          
          click_button "Adopt #{pet_1.name}"
          
          expect(page).to have_content("Applying For: Lucille Bald")
        end
      end
    end

    describe 'an application can be submitted after adding one or more pets to the app' do 
      before :each do 
        @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
        @pet_2 = @shelter.pets.create!(adoptable: true, age: 2, breed: 'american shorthair', name: 'Lucky')
        @pet_3 = @shelter.pets.create!(adoptable: true, age: 5, breed: 'labrador', name: 'Ted')
        @application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "In-Progress")
      end 
      it 'i only see submit button when more than one pet is added' do 
        visit "/applications/#{@application_1.id}"

        within("#change_status") do 
          expect(@application_1.pets).to eq([])
          expect(page).to_not have_content("Submit")
          expect(page).to_not have_content("Why will you make a good pet owner?")
        end
      end
      
      it 'i can fill out description and click submit and am taken back to show page' do 
        
        visit "/applications/#{@application_1.id}"
        fill_in 'pet_search', with: 'Lucille'
        click_button 'Search'  
        click_button "Adopt #{@pet_1.name}"
        
        expect(page).to have_content("Applying For: #{@pet_1.name}")
        within("#change_status") do 
          expect(page).to have_content("Why will you make a good pet owner?")
          fill_in 'description', with: 'I love cats'
          click_button("Submit")
        end 

        expect(page).to have_content("Application Status: Pending")
        
        within("#app_status") do 
          expect(page).to have_content("Why will you make a good pet owner? #{@application_1.description}")
        end

        expect(page).to have_content("Applying For: #{@pet_1.name}")
        expect(page).to_not have_content("Submit")
        expect(page).to_not have_content("Search")
        expect(page).to_not have_content("Adopt #{@pet_1.name}")
      end




    end
  end
end 