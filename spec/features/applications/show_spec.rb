require 'rails_helper'

RSpec.describe 'application show page', type: :feature do
  describe 'As a visitor' do
    before :each do
      @shelter = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      @pet1 = @shelter.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      @pet2 = @shelter.pets.create!(name: "Floofy", adoptable: true, age: 7, breed: "mixed breed")
      @application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")
      @pet_application1 = PetApplication.create!(pet: @pet1, application: @application)
      @pet_application2 = PetApplication.create!(pet: @pet2, application: @application)

    end
    it 'I can see all attributes of the application' do
      visit "/application/#{@application.id}"

      expect(page).to have_content('Samantha')
      expect(page).to have_content('Smith')
      expect(page).to have_content('123 Mulberry Street')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('20202')
      expect(page).to have_content('I would like this dog for these reasons.')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Fluffy')
      expect(page).to have_content('Floofy')
    end

    it 'I has links for the first pet that leads to a show page' do
      visit "/application/#{@application.id}"

      expect(page).to have_content('Fluffy')
      click_link('Fluffy')
      expect(current_path).to eq("/pets/#{@pet1.id}")
      #  (all names of pets should be links to their show page)
    end

    it 'I has links for the second pet that leads to that show page' do
      visit "/application/#{@application.id}"

      expect(page).to have_content('Floofy')
      click_link('Floofy')
      expect(current_path).to eq("/pets/#{@pet2.id}")
    end
  end
end
