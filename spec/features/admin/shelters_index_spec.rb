require 'rails_helper'
require 'test_helper'

# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name

RSpec.describe "Admin Shelters Index" do
  describe "User Story 10" do
    it 'shows all Shelters listed in reverse alphabetical order' do
      seed_shelters
      visit '/admin/shelters'
      
      expect("Ruff Day").to appear_before("Healthy Paws")
      expect("Healthy Paws").to appear_before("AAA Shelter")
    end
  end
  
  # As a visitor
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see a section for "Shelter's with Pending Applications"
  # And in this section I see the name of every shelter that has a pending application

  describe "User Story 11" do
    it 'has a section for shelters with pending applications' do
      seed_shelters
      seed_applications

      visit '/admin/shelters'

      expect(page).to have_content("Shelter's with Pending Applications")
    end

    it 'will show the name of every shelter that has pending applications' do
      shelter_1 = Shelter.create!(foster_program: true, name: "Healthy Paws", city: "Denver", rank: 3)
      shelter_2 = Shelter.create!(foster_program: true, name: "Ruff Day", city: "Detroit", rank: 2)
      shelter_3 = Shelter.create!( foster_program: true, name: "AAA Shelter", city: "Houston", rank: 1)

      pet_1 = Pet.create!( name: "Pepper", adoptable: true, age: 4, breed: "Pitbull", shelter_id: shelter_1.id)   
      pet_2 = Pet.create!( name: "Daisy", adoptable: true, age: 14, breed: "Beagle", shelter_id: shelter_1.id)
      pet_3 = Pet.create!( name: "Pumba", adoptable: true, age: 14, breed: "Corgi", shelter_id: shelter_2.id)
      pet_4 = Pet.create!( name: "Timon", adoptable: true, age: 14, breed: "Dacshund", shelter_id: shelter_3.id)

      application_1 = Application.create!( name: "Bob", street_address: "123 Leaf Street", city: "Denver", state: "CO", zip_code: 80020, description: "Work from home", status: "In Progress")
      application_2 = Application.create!( name: "Tom", street_address: "508 Maple Street", city: "Denver", state: "CO", zip_code: 80020, description: "Love animals", status: "Pending")
      application_3 = Application.create!( name: "Sam", street_address: "8591 Pine Street", city: "Denver", state: "CO", zip_code: 80021, description: "Have a large yard for a furbaby", status: "Pending")
      application_4 = Application.create!( name: "Susan", street_address: "2210 Palm Street", city: "Denver", state: "CO", zip_code: 80240, description: "Looking for a running  buddy", status: "In Progress")

      application_pet_1 = ApplicationPet.create!(application: application_1, pet: pet_1)
      application_pet_2 = ApplicationPet.create!(application: application_2, pet: pet_2)
      application_pet_3 = ApplicationPet.create!(application: application_3, pet: pet_3)
      application_pet_4 = ApplicationPet.create!(application: application_4, pet: pet_1)
  
      visit '/admin/shelters'

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
  end
end