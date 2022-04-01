require 'rails_helper'

RSpec.describe 'applications' do
  describe '#show' do
    before (:each) do
      @shelter = Shelter.create!(foster_program: true, name: "GoodPets", city: "Denver", rank: 6000)
      @pet = @shelter.pets.create!(adoptable: true, age: 3, breed: "Shepard", name: "Alfonso")
      @application = @pet.applications.create!(name: "Billy Swanson", address: "543 Cherry St, Denver, CO 80033")
      visit "/applications/#{@application.id}"
    end

    it 'can show the name of the applicant' do
      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.address)
      expect(page).to have_content(@pet.name)
    end

    it 'can link to a pets show page' do
      expect(page).to have_link(@pet.name)

      click_link @pet.name

      expect(current_path).to eq("/pets/#{@pet.id}")
    end
  end
end
