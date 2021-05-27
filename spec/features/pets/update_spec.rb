require 'rails_helper'

RSpec.describe 'pet update' do

  context "given valid data" do
    it "submits the edit form" do
      shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', shelter_id: shelter.id)
      pet = Pet.create(adoptable: true, age: 3, breed: 'GSD', name: 'Joe', shelter_id: shelter.id)

      visit "/pets/#{pet.id}/edit"

      fill_in 'Name', with: 'Pear'
      uncheck 'Adoptable'
      fill_in 'Age', with: 1
      click_button 'Save'

      expect(page).to have_current_path("/pets/#{pet.id}")
      expect(page).to have_content('Pear')
      expect(page).to_not have_content('Joe')
    end
  end

  context "given invalid data" do
    it 're-renders the edit form' do
      shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Joe', shelter_id: shelter.id)
      pet = Pet.create(adoptable: false, age: 3, breed: 'Whippet', name: 'Frank', shelter_id: shelter.id)

      visit "/pets/#{pet.id}/edit"

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/pets/#{pet.id}/edit")
    end
  end
end
