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

    # it 'has a link to pet show page' do
    #   visit "/applications/#{@app_1.id}"

    #   click_on "#{@pet_1.name}"

    #   expect(current_path).to eq("pets/#{@pet_1.id}")

    # end
  end

  describe 'does not have submitted application' do
    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_1 = @shelter_1.pets.create(name: 'Mrs. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
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
  end
end