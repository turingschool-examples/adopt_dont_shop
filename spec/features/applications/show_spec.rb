require 'rails_helper'

 RSpec.describe 'applications show page' do

   it "displays applicant attributes" do
     application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'Approved')
     shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
     pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
     pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)
     PetApplication.create(pet: pet_1, application: application_1)

     visit "/applications/#{application_1.id}"
     # save_and_open_page

     expect(page).to have_content(application_1.name)
     expect(page).to have_content(application_1.address)
     expect(page).to have_content(application_1.city)
     expect(page).to have_content(application_1.state)
     expect(page).to have_content(application_1.zipcode)
     expect(page).to have_content(application_1.description)
     expect(page).to have_content(application_1.status)
   end

   it 'can display Adopt This Pet button next to each pets name' do
     application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'Approved')
     shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
     pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
     pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)

     # As a visitor
     # When I visit an application's show page
     visit "/applications/#{application_1.id}"
     save_and_open_page
     # And that application has not been submitted,
     expect(page).to_not have_content('Queso')

     # Then I see a section on the page to "Add a Pet to this Application"
     # In that section I see an input where I can search for Pets by name
     # When I fill in this field with a Pet's name
     fill_in(:search, with: 'Queso')
     click_button("Search")
     # And I click submit,
     click_link("Adopt this Pet")
     # Then I am taken back to the application show page
     expect(current_path).to eq("/applications/#{application_1.id}")
     # And under the search bar I see any Pet whose name matches my search
     expect(page).to have_content("Queso")
   end

   it 'after pets added to app - description prompt & submit button appears' do
     application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'Approved')
     shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
     pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
     pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)
     PetApplication.create(pet: pet_1, application: application_1)

     # As a visitor
     # When I visit an application's show page
     visit "/applications/#{application_1.id}"


     # And I search for a Pet by name
     fill_in(:search, with: 'Gibblets')
     # And I see the names Pets that match my search
     # Then next to each Pet's name I see a button to "Adopt this Pet"

     click_button("Search")
     # When I click one of these buttons
    click_button("Adopt this Pet")

     # Then I am taken back to the application show page
       expect(page).to have_button("Submit Application")

     # And I see the Pet I want to adopt listed on this application
     fill_in(:search, with: 'Queso')
     click_button("Search")

     click_button("Adopt this Pet")

     fill_in(:description, with: 'Really REALLY good guy')
     click_button("Submit Application")
     expect(current_path).to eq("/applications/#{application_1.id}")

     expect(page).to_not have_content("In Progress")
     expect(page).to_not have_content('div.pet_search')
     expect(page).to have_content("Pending")
   end
 end
