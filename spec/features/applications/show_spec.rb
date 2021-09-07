require 'rails_helper'

RSpec.describe 'Application show page' do
  describe 'Applications show page contains' do
    before :each do
      @app = Application.create!(name: 'Oz', street_address: '3504 Gloria Ave.', city: 'Chicago', state: 'IL', zip_code: '80206', status: 'In Progress')
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @app.pets << @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @app.pets << @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @app.pets << @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      @pet_4 = @shelter_1.pets.create(name: 'Pesto', breed: 'ragdoll', age: 3, adoptable: true)
      @pet_5 = @shelter_1.pets.create(name: 'Spike', breed: 'mut', age: 6, adoptable: true)
      @app_2 = Application.create!(name: 'Joe', street_address: '7773 Ruth Ave.', city: 'Bull', state: 'NY', zip_code: '80206', status: 'In Progress')
      @app_3 = Application.create!(name: 'Bill', street_address: '7773 Ruth Ave.', city: 'Bull', state: 'NY', zip_code: '80206', status: 'In Progress')
      @app_2.pets << @pet_6 = @shelter_1.pets.create(name: 'Buddy', breed: 'mut', age: 6, adoptable: true)
    end

    it 'returns Application attributes' do
      visit("/applications/#{@app.id}")

      expect(page).to have_content('Oz')
      expect(page).to have_content('3504 Gloria Ave.')
      expect(page).to have_content('Chicago')
      expect(page).to have_content('IL')
      expect(page).to have_content('80206')
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

    it 'add a Pet to an Application' do
      visit("/applications/#{@app.id}")

      fill_in("Add a Pet to this Application", with: 'Pes')
      click_button("Search")

      within '#Pesto' do
        click_button("Adopt this Pet")
      end
      @app_pets = ApplicationPet.last

      expect(current_path).to eq("/applications/#{@app.id}")
      expect(@app_pets.pet_id).to eq(@pet_4.id)
    end

    it 'does not returns submit button when pets are added' do
      visit("/applications/#{@app_2.id}")

      expect(page).not_to have_content("Submit My Application")
    end

    it 'can submit an applicaton' do
      visit("/applications/#{@app.id}")

      fill_in("Enter why you would make a good owner for these pet(s)", with: "Because I'm awesome!")
      click_button("Submit My Application")
      @app.reload

      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content("Mr. Pirate")
      expect(page).to have_content("Clawdia")
      expect(page).to have_content("Ann")
      expect(@app.status).to eq("Pending")
    end

    it 'returns to app show page w/error message' do
      visit("/applications/#{@app.id}")

      click_button("Submit My Application")

      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content("Must submit reason for ownership!")
    end

    it 'does not show Submit My Application if no pets are added' do
      visit("/applications/#{@app_3.id}")

      expect(page).not_to have_button("Submit My Application")
    end
  end
end
