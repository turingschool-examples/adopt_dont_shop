require 'rails_helper'

describe 'As a visitor' do
  describe "When I visit the admin shelter index ('/admin/shelters')" do
    let!(:shelter_1) {Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
    let!(:shelter_2) {Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)}
    let!(:shelter_3) {Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}

    it 'I see all Shelters in the system listed in reverse alphabetical order by name' do
      visit '/admin/shelters'
      expect(page).to have_content('Aurora shelter')
      expect(page).to have_content('RGV animal shelter')
      expect(page).to have_content('Fancy pets of Colorado')

      expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
      expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    end

    describe "I see a section for 'Shelters with Pending Applications'" do
      it 'in this section I see the name of every shelter that has a pending application' do
        app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, status: 'Pending', description: 'i luv animals')
        pet_1 = app_1.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)
  
        app_2 = Application.create(name: 'Nick Fury', street_address: '123 Avenger Ave', city: 'New York', state: 'NY', zip: 28938, status: 'Pending', description: 'im rlly cool')
        pet_2 = app_2.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_2.id)

        visit '/admin/shelters'
        save_and_open_page
        expect(page).to have_content("Shelters with Pending Applications\nAurora shelter\nRGV animal shelter")
      end
    end
  end

end