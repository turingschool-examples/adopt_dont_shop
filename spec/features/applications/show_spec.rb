require 'rails_helper'

RSpec.describe '/applications/:id', type: :feature do
  let!(:application_1) { Application.create!(name: 'Taylor', address: '123 Side St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals') }
  let!(:application_2) { Application.create!(name: 'Thomas', address: '456 Main St', city: 'Denver', state: 'CO', zip: '80123', description: 'I hate animals') }
  
  let!(:shelter) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }

  let!(:bella) { shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) }
  let!(:rigby) { shelter.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) }
  let!(:luna) { shelter.pets.create!(name: 'Luna', age: 4, breed: 'Pitbull', adoptable: true) }

  let!(:pet_app_1) { PetApplication.create!(pet: bella, application: application_1) }
  let!(:pet_app_2) { PetApplication.create!(pet: rigby, application: application_1) }

  describe ' When I visit the applications show page' do
    it 'I can see all attributes of the application' do
      visit "/applications/#{application_1.id}" 

      expect(page).to have_content("Name: Taylor")
      expect(page).to have_content("Address: 123 Side St, Denver, CO 80202")
      expect(page).to have_content("Description: I love animals")
      expect(page).to have_content("Status: In Progress")

    end

    it 'I can see all pets that this application is for and they are links that go to that pets show page' do
      visit "/applications/#{application_1.id}" 
      expect(page).to have_content("Pets on Application:")
      expect(page).to have_link("Bella")
      expect(page).to have_link("Rigby")

      click_link "Bella"

      expect(current_path).to eq("/pets/#{bella.id}")
    end

    it 'If the application has not been submitted, I can search for pets by name' do
      visit "/applications/#{application_1.id}"

      expect(page).to have_content("Add a Pet to this Application")
      
      fill_in 'Pet Name', with: "Luna"
      
      click_button "Search"

      expect(current_path).to eq("/applications/#{application_1.id}")
      expect(page).to have_content("Luna")
      expect(page).to have_button('Adopt this Pet')
    end

    it 'If the application has not been submitted, I can add a pet to the application' do
      visit "/applications/#{application_1.id}"

      fill_in 'Pet Name', with: "Luna"
      
      click_button "Search"
      click_button 'Adopt this Pet'

      expect(current_path).to eq("/applications/#{application_1.id}")
      expect(page).to have_link("Luna")
    end
  end

  describe 'Submit Application' do
    it 'If the application does not have any pets then there is no submit button' do
      visit "/applications/#{application_2.id}"
      
      expect(page).to_not have_content('Why would you make a good owner to these pet(s)?')
      expect(page).to_not have_button('Submit Application')
    end
    
    it 'If the application does have pets then there is a submit button and a text field' do
      visit "/applications/#{application_1.id}"
      
      expect(page).to have_content('Why would you make a good owner to these pet(s)?')
      expect(page).to have_button('Submit Application')
    end

    it 'If the submit button is clicked, the application status changes to "Pending"' do
      visit "/applications/#{application_1.id}"
      fill_in :good_owner, with: 'They are good pets'
      click_button('Submit Application')

      expect(current_path).to eq("/applications/#{application_1.id}")
      expect(page).to have_content("Status: Pending")
    end
    
    it 'If the application has been submitted, I can no longer search for pets' do
      visit "/applications/#{application_1.id}"
      fill_in :good_owner, with: 'They are good pets'
      click_button('Submit Application')

      expect(page).to_not have_content('Add a Pet to this Application')
      expect(page).to_not have_button('Search')
      expect(page).to_not have_button('Submit Application')
    end
  end
end