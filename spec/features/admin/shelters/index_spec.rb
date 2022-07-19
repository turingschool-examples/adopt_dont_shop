require 'rails_helper'

RSpec.describe 'Admin/shelters#index' do
  describe 'when I visit the admin shelters index page' do
    before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_4 = Shelter.create(name: 'Animal Helpers', city: 'Portland, OR', foster_program: true, rank: 3)


    @pet_1 = Pet.create!(name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: @shelter_2.id)
    @pet_3 = Pet.create!(name: 'Daisy', age: 3, breed: 'cat', adoptable: true, shelter_id: @shelter_3.id)

    @app_1 = Application.create!(name: 'John Doe', street_address: '123 Main St', city: 'New York',
                                        state: 'NY', zipcode: 10_001)
    @app_2 = Application.create!(name: 'Jane Doe', street_address: '456 Main St', city: 'Boston',
                                          state: 'MA', zipcode: 10_002)
    @app_3 = Application.create!(name: 'Mo', street_address: '789 Main St', city: 'Boston',
                                          state: 'MA', zipcode: 10_002)

    @pet_application_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_2.id, status: 'Pending')
    @pet_application_2 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_1.id, status: 'Pending')
    @pet_application_3 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_2.id, status: 'Rejected')
    @pet_app_4 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_3.id, status: 'Pending')
    end
    it 'shows me that I am on the admin shelters index page' do
      visit '/admin/shelters'
      expect(page).to have_content('Admin View')
      expect(page).to have_content('All Shelters')
    end

    it 'I see all shelters ordered by reverse alphabetical order' do
      dog_homes = Shelter.create!(name: "Dog Home", city: "Denver", rank: 1, foster_program: true)
      paw_place = Shelter.create!(name: "Paw Place", city: "Boulder", rank: 2, foster_program: true)
      furry_friends = Shelter.create!(name: "Furry Friends", city: "Aurora", rank: 3, foster_program: false)
      
      visit '/admin/shelters'

      within("#pet_shelters_admin") do
        expect("Paw Place").to appear_before("Furry Friends")
        expect("Furry Friends").to appear_before("Dog Home")
      end
    end
    it 'has a section that shows all shelters with pets that have pending applications' do
      visit '/admin/shelters'

      within('#pending_applications_admin') do
        expect(page).to have_content('Aurora shelter')
        expect(page).to have_content('RGV animal shelter')
        expect(page).to_not have_content('Animal Helpers')
      end
    end
    it 'lists the shelters alphabetically in the shelters with pending applications' do
      visit '/admin/shelters'

      within('#pending_applications_admin') do
        expect('Aurora shelter').to appear_before('RGV animal shelter')
        expect('Fancy pets of Colorado').to appear_before('RGV animal shelter')
      end
    end
  end
end