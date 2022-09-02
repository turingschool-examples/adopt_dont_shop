require 'rails_helper'

RSpec.describe 'application show page', type: :feature do
  describe 'As a visitor' do
    before :each do
      @shelter = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      @pet1 = @shelter.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      @pet2 = @shelter.pets.create!(name: "Floofy", adoptable: true, age: 7, breed: "mixed breed")
      @pet3 = @shelter.pets.create!(name: "Butters", adoptable: true, age: 6, breed: "lab")
      @application1 = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")
      @application2 = Application.create!(first_name: "Peter", last_name: "Pinckens", street_address: "123 Pineapple Street", city: "Denver", state: "CO", zip_code: 72641, description: "I would really like an animal to keep me company", status: "In Progress")

    end
    it 'I can see all attributes of the application' do
      visit "/applications/#{@application1.id}"

      expect(page).to have_content('Samantha')
      expect(page).to have_content('Smith')
      expect(page).to have_content('123 Mulberry Street')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('20202')
      expect(page).to have_content('I would like this dog for these reasons.')
      expect(page).to have_content('In Progress')
    end

    it 'I has a search bar where you can search for pets' do
      visit "/applications/#{@application1.id}"
      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_content('Search for pet by name:')
    end

    it 'I can fill in the search bar & then see all pets whose names match' do
      visit "/applications/#{@application1.id}"
   
      fill_in('Search for pet by name:', with: 'Fluffy')
      click_on('Search for Pet')

      expect(page).to have_content('Fluffy')
      click_link('Fluffy')
    end

  end
end
