require 'rails_helper'

RSpec.describe 'application show page' do
  describe ' as a visitor on the show page' do
    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @app_1 = Application.create!(name: 'JoJo', address: '23 Tanby', city: 'Denver', state: 'CO', zip: '90345', description: 'I have dog food and a roof', status: "In Progress")
      PetApplication.create!(application: @app_1, pet: @pet_1)
    end

    it 'displays an application with attributes'do
      visit "/applications/#{@app_1.id}"

      expect(page).to have_content(@app_1.name)
      expect(page).to have_content(@app_1.address)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.state)
      expect(page).to have_content(@app_1.zip)
      expect(page).to have_content(@app_1.description)
      expect(page).to have_content(@app_1.status)
      expect(page).to have_content(@pet_1.name)
    end

    it 'has pet add header in search section' do
      visit "/applications/#{@app_1.id}"

      within(".search") do
        page.should have_content("Add a Pet to this Application")
      end
    end
  end

  describe 'does not have submitted application' do
    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @app_1 = Application.create!(name: 'JoJo', address: '23 Tanby', city: 'Denver', state: 'CO', zip: '90345', description: 'I have dog food and a roof', status: "In Progress")
    end

    it 'display a place to add a pet to application' do
      visit "/applications/#{@app_1.id}"
      expect(page).to have_content("Add a Pet to this Application")
    end

    it 'can search for pets' do
      visit "/applications/#{@app_1.id}"
      fill_in 'pet_name', with: 'Mr. Pirate'
      click_on 'Search'

      expect(page).to have_content("Mr. Pirate")
      expect(page).to have_no_content("Mrs. Pirate")
      expect(page).to have_content(@pet_1.breed)
      expect(page).to have_content(@pet_1.age)
    end

    it 'can add pet' do
      visit "/applications/#{@app_1.id}"
      fill_in 'pet_name', with: 'Mr. Pirate'
      click_on 'Search'
      click_on 'Adopt this pet'

      expect(page).to have_link 'Mr. Pirate'
      expect(page).to have_current_path("/applications/#{@app_1.id}")
    end

    it 'has submit application section' do
      visit "/applications/#{@app_1.id}"

      expect(page).to have_no_content('Submit Application')

      fill_in 'pet_name', with: 'Mr. Pirate'
      click_on 'Search'
      click_on 'Adopt this pet'

      expect(page).to have_content('Submit Application')

      fill_in 'description', with: 'I have cookies'

      click_on 'Submit'

      expect(page).to have_no_content('Submit Application')
      expect(page).to have_link 'Mr. Pirate'
    end
  end

  describe 'can search for pets by partial name' do
    before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Pinhead', breed: 'guinea pig', age: 1, adoptable: true)
    @app_1 = Application.create!(name: 'JoJo', address: '23 Tanby', city: 'Denver', state: 'CO', zip: '90345', description: 'I have dog food and a roof', status: "In Progress")
    end

    it 'displays all matches for partial name search' do
      visit "/applications/#{@app_1.id}"

      fill_in 'pet_name', with: 'Pi'
      click_on 'Search'

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
    end
  end

  describe 'can search for pets by name' do
    before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: 'Mr. pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'PInhead', breed: 'guinea pig', age: 1, adoptable: true)
    @app_1 = Application.create!(name: 'JoJo', address: '23 Tanby', city: 'Denver', state: 'CO', zip: '90345', description: 'I have dog food and a roof', status: "In Progress")
    end

    it 'displays all matches that are case insensitive' do
      visit "/applications/#{@app_1.id}"

      fill_in 'pet_name', with: 'Pi'
      click_on 'Search'

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
    end
  end
end