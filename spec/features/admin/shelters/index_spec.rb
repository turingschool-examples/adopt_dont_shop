require 'rails_helper'

RSpec.describe Shelter do
  describe 'Admin Shelters' do
    it 'lists all the shelters in reverse alpha by name' do
      shelter1 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      visit '/admin/shelters'
      
      within '.shelters' do
        expect(shelter1.name).to appear_before(shelter3.name)
        expect(shelter3.name).to appear_before(shelter2.name)
        expect(shelter2.name).to_not appear_before(shelter1.name)
      end
    end

    it 'in section for pending apps shows the shelters name' do
      shelter1 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      pet1 = shelter1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      pet2 = shelter1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

      app1 = Applicant.create!(name: "Billy Wahl", street_address: "123 S Street Way",
                    city: "Denver", state: "CO", zip_code: "80123", description: "I Like Dogs", status: 'Pending')
      
      pet_app1 = PetApplicant.create!(pet_id: pet1.id, applicant_id: app1.id)
      pet_app2 = PetApplicant.create!(pet_id: pet2.id, applicant_id: app1.id)

      visit '/admin/shelters'

      within '.pending_apps' do
        expect(page).to have_link(shelter1.name)
        expect(page).to_not have_link(shelter2.name)
        expect(page).to_not have_link(shelter3.name)
      end

      #Left off in the spec/models/shelter_spec.rb:52
    end

  end
end

# @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
# @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
# @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
# @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
# @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
# @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)