require 'rails_helper'

RSpec.describe 'the apps show', type: :feature do
  describe 'as a visitor, when I visit an apps show page' do
    before(:each) do
      @shelter_1 = Shelter.create!(foster_program: true, name: 'Boulder Humane Society', city: 'Boulder', rank: 3)
      @app_1 = App.create!(name: 'John Travolta', street_address: '1111 Greasy Lane', city: 'Frisco', state: 'CO', zip_code: '80678', description: 'I like dogs. Dogs are cool. You should give me a dog.', status: 'In Progress')
      @pet_1 = @app_1.pets.create!(adoptable: true, age: 3, breed: 'German Shepard', name: 'Zues', shelter_id: @shelter_1.id)
      @pet_2 = @app_1.pets.create!(adoptable: true, age: 1, breed: 'Siberian Husky', name: 'John Snow', shelter_id: @shelter_1.id)
      @pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'Chihuahua', name: 'Maximus', shelter_id: @shelter_1.id)
    end

    it 'I can see applications information' do
      visit "/apps/#{@app_1.id}"

      expect(page).to have_content("#{@app_1.name}'s Application for Adoption")
      expect(page).to have_content("Street Address: #{@app_1.street_address}")
      expect(page).to have_content("City: #{@app_1.city}")
      expect(page).to have_content("State: #{@app_1.state}")
      expect(page).to have_content("Zip Code: #{@app_1.zip_code}")
      expect(page).to have_content("Description: #{@app_1.description}")
      expect(page).to have_content("Applied to Adopt:")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content("Application Status: #{@app_1.status}")
    end

    it 'I can click on links that go to pets show page' do
      visit "/apps/#{@app_1.id}"

      expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
      click_link "#{@pet_1.name}"
      expect(current_path).to eq("/pets/#{@pet_1.id}")

      visit "/apps/#{@app_1.id}"
      
      expect(page).to have_link("#{@pet_2.name}", href: "/pets/#{@pet_2.id}")
      click_link "#{@pet_2.name}"
      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end

    it 'I can search and add a pet to my application' do
      visit "/apps/#{@app_1.id}"

      expect(page).to have_content("Add a pet to this Application")
      expect(page).to have_field('search')
      expect(page).to have_button('Search Pets')

      fill_in 'search', with: 'Maximus'
      click_button 'Search Pets'

      expect(page).to have_content('Maximus')
    end

    it 'I see a button to adopt a searched pet' do
      visit "/apps/#{@app_1.id}"

      fill_in 'search', with: 'Maximus'
      click_button 'Search Pets'
      expect(page).to have_content('Maximus')
      expect(@app_1.pets.count).to eq(2)

      expect('Add a pet to this Application').to appear_before(@pet_3.name)
      expect(page).to have_button('Adopt this Pet')

      click_button 'Adopt this Pet'

      expect(current_path).to eq("/apps/#{@app_1.id}")
      expect(@app_1.pets.count).to eq(3)
      expect(@pet_3.name).to appear_before('Add a pet to this Application')
    end
  end
end