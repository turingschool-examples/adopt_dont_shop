require 'rails_helper'

RSpec.describe 'Application Show' do
  before(:each) do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 7, breed: 'mut', name: 'Frog', shelter_id: shelter.id)
    @app_1 = Application.create!(first: "Joe", last: "Hilby", street: "1234 N A St", city: "Any Town", state: "AnyState", zip: "12345", description: "So cute!", status: "In Progress")
    ApplicationPet.create!(pet: @pet_1, application: @app_1)
    ApplicationPet.create!(pet: @pet_2, application: @app_1)
  end
  describe 'When I visit /application/:id' do
    it 'lists the select application with its attributes' do
      visit "/applications/#{@app_1.id}"

      expect(page).to have_content(@app_1.first)
      expect(page).to have_content(@app_1.last)
      expect(page).to have_content(@app_1.street)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.state)
      expect(page).to have_content(@app_1.zip)
      expect(page).to have_content(@app_1.description)
      expect(page).to have_content(@app_1.status)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
    end

    it 'has a section to add an additional pet to the application' do
      visit "/applications/#{@app_1.id}"

      expect(page).to have_content("Add a pet to this Application")
    end

    it 'has a section to search for a pet to add' do
      visit "/applications/#{@app_1.id}"
      fill_in :search, with: "#{@pet_3.name}"
      click_on "Search"

      expect(page).to have_content(@pet_3.name)
      expect(page).to have_button("Adopt this Pet")
    end

    it 'when I click on "Adopt this Pet" that pet is added to my application' do
      visit "/applications/#{@app_1.id}"
      fill_in :search, with: "#{@pet_3.name}"
      click_on "Search"
      click_on "Adopt this Pet"

      expect(current_path).to eq("/applications/#{@app_1.id}")
      expect(page).to have_content("Pets to Adopt: #{@pet_1.name} #{@pet_2.name} #{@pet_3.name}")
    end
  end

  describe 'when pets have been added to the application and I click "Submit"' do
    it 'my application changes to "Pending"' do
    visit "/applications/#{@app_1.id}"
      click_on "Submit"

      expect(page).to have_content("Pending")
    end

    it 'the section to search and add pets is removed' do
      visit "/applications/#{@app_1.id}"
      click_on "Submit"

      expect(page).to_not have_content("Add a pet to this Application")
    end
  end
end