require 'rails_helper'

RSpec.describe 'the pets index' do
  describe 'page appearance' do
    it 'lists all the pets with their attributes' do
      shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', description: 'Test', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Grey', description: 'Test',  shelter_id: shelter.id)

      visit "/pets"

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.breed)
      expect(page).to have_content(pet_1.age)

      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.breed)
      expect(page).to have_content(pet_2.age)
    end

    it 'only lists adoptable pets' do
      shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', description: 'Test', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Grey', description: 'Test', shelter_id: shelter.id)
      pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Joe', description: 'Test', shelter_id: shelter.id)

      visit "/pets"

      expect(page).to_not have_content(pet_3.name)
    end
  end

  describe 'page functionality' do
    it 'displays a link to edit each pet' do
      shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', description: 'Test', shelter_id: shelter.id)

      visit '/pets'

      expect(page).to have_content("Edit")

      click_link("Edit")

      expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
    end
    it 'displays a link to delete each pet' do
      shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', description: 'Test', shelter_id: shelter.id)

      visit '/pets'

      expect(page).to have_content("Delete")

      click_link("Delete")

      expect(page).to have_current_path("/pets")
      expect(page).to_not have_content(pet_1.name)
    end
    it 'has a text box to filter results by keyword' do
      visit "/pets"
      expect(page).to have_button("Search")
    end
    it 'lists partial matches as search results' do
      shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', description: 'Test', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Grey', description: 'Test', shelter_id: shelter.id)
      pet_3 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Sparky', description: 'Test', shelter_id: shelter.id)
      pet_4 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Joe', description: 'Test', shelter_id: shelter.id)

      visit "/pets"

      fill_in 'search', with: "Gr"
      click_on("Search")

      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)
    end
    it 'has a button that allows you to start a new application' do
      shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', description: 'Test', shelter_id: shelter.id)

      visit "/pets"
      save_and_open_page
      click_link "Adopt"

      expect(current_path).to eq('/applications/new')
    end
  end
end
