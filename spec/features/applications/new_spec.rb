require 'rails_helper'

RSpec.describe 'the new application page' do 
  describe 'when a visitor visits the new application page' do 
    it 'is a form to enter applicant details' do 
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      # application_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "In Progress", description: "I love cats")
      # PetApplication.create(pet: pet_1, application: application_1)
      # PetApplication.create(pet: pet_2, application: application_1)
      visit 'applications/new'

      fill_in :name, with: "Britney Spears"
      fill_in :street_address, with: "1234 Apple Ln"
      fill_in :city, with: "Aurora"
      fill_in :state, with: "CO"
      fill_in :zip_code, with: 80230
      # fill_in :status, with: "In Progress" 
      fill_in :description, with: "I like dogs"
      click_button("Submit Application")
      new_application_id = Application.last.id 
      expect(current_path).to eq("/applications/#{new_application_id}")
      visit "/applications/#{new_application_id}"
      expect(page).to have_content("In-Progress")
    end 

    it 'if a user fails to fill in any of the form fields and click submit, they are taken back to new app page with a message' do 
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      visit 'applications/new'
      fill_in :name, with: "Britney Spears"
      # fill_in :street_address, with: "1234 Apple Ln"
      fill_in :city, with: "Aurora"
      fill_in :state, with: "CO"
      fill_in :zip_code, with: 80230
      fill_in :description, with: "I like dogs"
      click_button("Submit Application")
      # new_application_id = Application.last.id 
      expect(current_path).to eq('/applications/create/')

      expect(page).to have_content("Error: Please fill out all fields")

    end
  end 
end 