require 'rails_helper'

RSpec.describe 'Application show page' do
  describe 'Applications show page contains' do
    before :each do
      @app = Application.create!(name: 'Oz', street_address: '3504 Gloria Ave.', city: 'Chicago', state: 'IL', zip_code: '80206', description: 'cool dude', status: 'In Progress')
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @app.pets << @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @app.pets << @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @app.pets << @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    end

    it 'returns Application attributes' do
      visit("/applications/#{@app.id}")

      expect(page).to have_content('Oz')
      expect(page).to have_content('3504 Gloria Ave.')
      expect(page).to have_content('Chicago')
      expect(page).to have_content('IL')
      expect(page).to have_content('80206')
      expect(page).to have_content('cool dude')
      expect(page).to have_content('In Progress')
    end

    it 'returns all pets associated with application' do
      visit("/applications/#{@app.id}")

      expect(page).to have_content('Mr. Pirate')
      expect(page).to have_content('Clawdia')
      expect(page).to have_content('Ann')

      click_link('Mr. Pirate')

      expect(current_path).to eq("/pets/#{@pet_1.id}")
    end

    it 'can add pets to an application' do
      visit("/applications/#{@app.id}")

      expect(page).to have_content("Add a Pet to this Application")

      fill_in("Add a Pet to this Application", with: 'Ann')
      click_button("Search")

      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content('Ann')
    end
    # application has not been submitted
  end
end
