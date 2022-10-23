require 'rails_helper'

RSpec.describe 'the admin shelters index page' do 
  describe 'when a visitor visits the index page' do 
    it 'has the names of all shelters listed in reverse alphabetical order' do 
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  
      visit '/admin/shelters'

      expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
      expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    end
    it 'has a section for shelters with pending applications' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      pet_1 = shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
      pet_2 = shelter_2.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
      app_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "Pending", description: "I love cats")
      app_2 = Application.create!(name: "John Doe", street_address: "123 Generic Ave", city: "Denver", state: "CO", zip_code: 80220, status: "In-Progress", description: "Dogs are cool")
      pet_app_1 = PetApplication.create(application_id: app_1.id, pet_id: pet_1.id)
      pet_app_2 = PetApplication.create(application_id: app_2.id, pet_id: pet_2.id)

      expect(Shelter.has_pending_apps).to eq([shelter_1])
    end
  end 
end 