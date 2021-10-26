require 'rails_helper'

RSpec.describe 'Applications' do
  context 'Show Page' do
    before(:each) do
      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @newapp = Application.create!({
        name: 'Chaz Simons',
        street_address: '1234 Cool Guy Rd',
        city: 'Las Vegas',
        state: 'NV',
        zip_code: 89106,
        good_fit: '',
        status: ''
        })
      @pet1 = @newapp.pets.create({
        name: 'Rex',
        age: 2,
        breed: 'boston terrier',
        adoptable: true,
        shelter_id: @shelter.id})
      @pet_2 = @shelter.pets.create({
        name: 'Fido',
        age: 1,
        breed: 'golden retriever',
        adoptable: true,
        shelter_id: @shelter.id
        })
      @pet_3 = @shelter.pets.create({
        name: 'Alfafa',
        age: 3,
        breed: 'brindle',
        adoptable: true,
        shelter_id: @shelter.id
        })
      @pet_4 = @shelter.pets.create({
        name: 'All Might',
        age: 1,
        breed: 'labrador',
        adoptable: true,
        shelter_id: @shelter.id
        })
      @pet_5 = @shelter.pets.create({
        name: 'Alpha',
        age: 1,
        breed: 'bulldog',
        adoptable: true,
        shelter_id: @shelter.id
        })
    end
    it 'will display an applications information' do
        visit "/applications/#{@newapp.id}"

        expect(page).to have_content(@newapp.name)
        expect(page).to have_content(@newapp.street_address)
        expect(page).to have_content(@newapp.zip_code)
        expect(page).to have_content(@newapp.status)
    end

    it 'can search for pets to add to an application' do
      visit "/applications/#{@newapp.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Search")
    end

    it 'returns a list of pets by name' do
      visit "/applications/#{@newapp.id}"
      fill_in :search, with: 'Fido'
      click_button "Search"

      expect(current_path).to eq("/applications/#{@newapp.id}")
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_button("Adopt me")
    end

    it 'returns a message if no pet matches' do
      visit "/applications/#{@newapp.id}"
      fill_in :search, with: 'Shadow'
      click_button "Search"

      expect(current_path).to eq("/applications/#{@newapp.id}")
      expect(page).to have_content("No pets match your search.")
      expect(page).to_not have_content(@pet_2.name)
    end

    it 'can add a pet to an application' do
      visit "/applications/#{@newapp.id}"
      fill_in :search, with: 'All Might'
      click_button "Search"
      click_button "Adopt me"

      expect(current_path).to eq("/applications/#{@newapp.id}")
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet_4.name)
    end

    # it 'has a submit application button if one or more pets is added to the application' do
    #   visit "/applications/#{@newapp.id}"
    #
    #   expect(page).to have_button("Submit Application")
    # end

    xit 'returns partial matches from search' do
      visit "/applications/#{@newapp.id}"
      fill_in :search, with: 'Al'
      click_button "Search"

      expect(current_path).to eq("/applications/#{@newapp.id}")
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_4.name)
      expect(page).to have_content(@pet_5.name)
    end
  end
end
