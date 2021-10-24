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
        shelter_id: @shelter.id})

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
    end

    it 'returns a message if no pet matches' do
      visit "/applications/#{@newapp.id}"
      fill_in :search, with: 'Shadow'
      click_button "Search"

      expect(current_path).to eq("/applications/#{@newapp.id}")
      expect(page).to have_content("No pets match your search.")
      expect(page).to_not have_content(@pet_2.name)
    end
  end
end
