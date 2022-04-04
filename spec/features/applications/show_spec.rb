require 'rails_helper'

RSpec.describe 'applications' do
  describe '#show' do
    before (:each) do
      @shelter = Shelter.create!(foster_program: true, name: "GoodPets", city: "Denver", rank: 6000)
      @pet1 = @shelter.pets.create!(adoptable: true, age: 3, breed: "Shepard", name: "Alfonso")
      @pet2 = @shelter.pets.create!(adoptable: true, age: 6, breed: "Shepard", name: "Geoffrey")
      @pet3 = @shelter.pets.create!(adoptable: true, age: 7, breed: "Shepard", name: "Alfonso")
      @application = @pet1.applications.create!(name: "Billy Swanson", street_address: "543 Cherry St", city: "Denver", state: "CO", zip_code: "80033")
      visit "/applications/#{@application.id}"
    end

    it 'can show the name of the applicant' do
      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.street_address)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zip_code)
      expect(page).to have_content(@pet1.name)
    end

    it 'can link to a pets show page' do
      expect(page).to have_link(@pet1.name)

      click_link @pet1.name

      expect(current_path).to eq("/pets/#{@pet1.id}")
    end

    it 'has a search bar to find pets by name' do
      fill_in :search, with: 'Alfonso'
      click_button 'Submit'

      expect(current_path).to eq("/applications/#{@application.id}?search=Alfonso")

      within '#search-bar' do
        expect(page).to have_content("Name: Alfonso")
        expect(page).to have_content("Age: 3")
        expect(page).to have_content("Age: 6")
        expect(page).to have_content("Adoptable: True")
        expect(page).to have_content("Breed: Shepard")

        expect(page).to_not have_content("Geoffrey")
        expect(page).to_not have_content("Adoptable: False")
        expect(page).to_not have_content("Age: 7")
      end
    end
  end
end
