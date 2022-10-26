require 'rails_helper'

RSpec.describe 'Application Show' do
  before(:each) do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 7, breed: 'mut', name: 'Frog', shelter_id: shelter.id)
    @app_1 = Application.create!(first: "Joe", last: "Hilby", street: "1234 N A St", city: "Any Town", state: "AnyState", zip: "12345", description: "Such a good home.", status: "In Progress")
    @app_2 = Application.create!(first: "John", last: "Smith", street: "1234 N A St", city: "Any Town", state: "AnyState", zip: "12345", status: "In Progress")
    ApplicationPet.create!(pet: @pet_1, application: @app_1)
    ApplicationPet.create!(pet: @pet_2, application: @app_1)
  end
  describe 'When I visit /application/:id' do
    describe 'Then I see' do
      it 'the select application with its attributes' do
        visit "/applications/#{@app_1.id}"

        expect(page).to have_content(@app_1.first)
        expect(page).to have_content(@app_1.last)
        expect(page).to have_content(@app_1.street)
        expect(page).to have_content(@app_1.city)
        expect(page).to have_content(@app_1.state)
        expect(page).to have_content(@app_1.zip)
        expect(page).to have_content(@app_1.description)
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@app_1.status)
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)
      end

      it 'a section to add an additional pet to the application' do
        visit "/applications/#{@app_1.id}"

        expect(page).to have_content("Add a pet to this Application")
      end

      it 'a section to search for a pet to add' do
        visit "/applications/#{@app_1.id}"
        fill_in :search, with: "#{@pet_3.name}"
        click_on "Search"

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content(@pet_3.name)
        expect(page).to have_button("Adopt this Pet")
      end
    end

    describe 'When I click on "Adopt this Pet"' do
      it 'the pet is added to my application' do
        visit "/applications/#{@app_1.id}"
        fill_in :search, with: "#{@pet_3.name}"
        click_on "Search"
        click_on "Adopt this Pet"

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content("Pets to Adopt: #{@pet_1.name} #{@pet_2.name} #{@pet_3.name}")
      end

      it 'then I see a box to input why I would make a good owner and button to submit my application' do
        visit "/applications/#{@app_2.id}"
        expect(page).to_not have_button("Submit")
        expect(page).to_not have_content('Tell us about your home:')

        fill_in :search, with: "#{@pet_3.name}"
        click_on "Search"
        click_on "Adopt this Pet"

        expect(page).to have_content('Tell us about your home:')
        expect(page).to have_button("Submit")
      end
    end
  end

  describe 'When pets have been added to the application and I click "Submit"' do
    it 'my application changes to "Pending"' do
    visit "/applications/#{@app_1.id}"
      click_on "Submit"

      expect(current_path).to eq("/applications/#{@app_1.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content("Lucille")
    end

    it 'the section to search and add pets is removed' do
      visit "/applications/#{@app_1.id}"
      click_on "Submit"

      expect(page).to_not have_content("Add a pet to this Application")
    end

    it 'the submit application button is not visibal untill a pet is added' do
      visit "/applications/#{@app_2.id}"

      expect(page).to_not have_button("Submit")
    end
  end
end