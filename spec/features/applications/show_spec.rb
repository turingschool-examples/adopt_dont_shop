require 'rails_helper'

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

RSpec.describe 'Application Show Page' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 2, breed: 'sphynx', name: 'Sphynx', shelter_id: @shelter.id)
    @application_1 = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'In Progress')
    PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
  end
  
   describe 'As a visitor' do
    it 'I can see the application and its attributes' do
      visit "/applications/#{@application_1.id}"
      
      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content("Lucille Bald")
      expect(page).to have_content("Sphynx")
      expect(page).to have_content(@application_1.status)
    end
  end

  describe 'As a visitor' do
    describe 'When I visit an applications show page' do
      it 'I can see a section to search for pets by name' do
        visit "/applications/#{@application_1.id}"
        
        expect(page).to have_content("Add Pet to Application")
        expect(page).to have_content("Pet name")
        expect(page).to have_field(:pet_name)
        expect(page).to have_button("Search")
      end

      it 'I can search for pets by name' do
        visit "/applications/#{@application_1.id}"

        fill_in :pet_name, with: "Lucille"
        click_button "Search"

        expect(page).to have_content("Lucille Bald")
        expect(page).to_not have_content("Lobster")
      end
    end
  end
end