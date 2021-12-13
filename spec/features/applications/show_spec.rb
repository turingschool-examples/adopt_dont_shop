require 'rails_helper'

RSpec.describe 'application show' do

  it 'shows application' do
    @application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304')
    # binding.pry
    visit "/applications/#{@application.id}"
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
  end

  it 'can search for pets to add to application' do
    @application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304')
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: "#{@shelter_1.id}")

    visit("/applications/#{@application.id}")
    expect(page).to have_content("Add a Pet to this Application")
    fill_in("Pet name", with: @pet_1.name)
    click_on "Search pets by name"
    # binding.pry
    expect(current_path).to eq("/applications/#{@application.id}")
    # save_and_open_page
    expect(page).to have_content(@pet_1.name)
  end

  it 'can add a pet to the application' do
    @application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304')
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: "#{@shelter_1.id}")

    visit("/applications/#{@application.id}")
    expect(page).to have_content("Add a Pet to this Application")
    fill_in("Pet name", with: @pet_1.name)
    click_button "Search pets by name"

    click_button "Adopt this pet"
    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content(@pet_1.name)

  end


  describe 'after adding a pet on an application show page' do
    it 'has a submit appplication section' do
      @application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304')
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: "#{@shelter_1.id}")

      visit("/applications/#{@application.id}")
      expect(page).to have_content("Add a Pet to this Application")
      fill_in("Pet name", with: @pet_1.name)
      click_button "Search pets by name"
      save_and_open_page
      expect(page).to have_button("Adopt this pet")
      click_button "Adopt this pet"
      expect(current_path).to eq("/applications/#{@application.id}")

      # expect(page).to have_content('Sub')

    end

  end


end
