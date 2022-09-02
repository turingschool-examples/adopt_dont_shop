require 'rails_helper'

# - names of all pets that this application is for (all names of pets should be links to their show page)

RSpec.describe 'application show page', type: :feature do
  describe 'As a visitor' do
    before :each do
      @shelter = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      @pet = @shelter.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      @application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")
      @pet_application1 = PetApplication.create!(pet: @pet, application: @application)
    end
    it 'I can see all attributes of the application' do
      visit "/application/#{@application.id}"

      save_and_open_page
      expect(page).to have_content('Samantha')
      expect(page).to have_content('Smith')
      expect(page).to have_content('123 Mulberry Street')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('20202')
      expect(page).to have_content('I would like this dog for these reasons.')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Fluffy')
    end
  end
end
