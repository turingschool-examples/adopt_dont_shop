require 'rails_helper'

RSpec.describe 'the applications show page' do 
  describe 'when a visitor visits the applications show page' do 
    it 'shows the applicant and all its attributes' do 
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "In Progress", description: "I love cats")
      # lucille_app = pet_1.applications.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "In Progress", description: "I love cats")
      PetApplication.create(pet: pet_1, application: application_1)
      save_and_open_page
      # require 'pry'; binding.pry
      visit "/applications/#{application_1.id}"
      expect(page).to have_content(application_1.name)
      expect(page).to have_content(application_1.street_address)
      expect(page).to have_content(application_1.city)
      expect(page).to have_content(application_1.state)
      expect(page).to have_content(application_1.zip_code)
      expect(page).to have_content(application_1.status)
      expect(page).to have_content(application_1.description)
      expect(page).to have_content(application_1.pets.name)
       
      save_and_open_page
    end
  end
end 