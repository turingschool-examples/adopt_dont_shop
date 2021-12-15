require 'rails_helper'
RSpec.describe "Admin Shelter Index Page" do 
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    
    @pet1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
   
    @application_1 = @pet1.apps.create!(name: "Rick James", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 0)
    @application_2 = @pet2.apps.create!(name: "Charlie Murphy", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 1)
    @application_3 = @pet3.apps.create!(name: "Prince", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 1)

    visit "/admin/shelters"
  end 
  describe 'as a visitor' do 
    describe 'when i visit the admin shelter/s index' do 
      it 'shows all Shelters in the system in reverse alphabetical order' do 
        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
      end 

      it 'has a section for Shelters with Pending Applications' do 
        expect(page).to have_content("Pending")
      end 
    end 
  end 
end 