require 'rails_helper'

RSpec.describe 'Admin Shelter Show' do
  describe 'As a visitor' do
    it 'will show the name and full address of the specified Shelter' do
      northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)

      visit "/admin/shelters/#{northshore.id}"

      expect(page).to have_content(northshore.name)
      expect(page).to have_content(northshore.city)
      expect(page).to have_content(northshore.street_address)
      expect(page).to have_content(northshore.state)
      expect(page).to have_content(northshore.zip_code)
    end

    it 'will show me a section for statistics and in that section i will see the average age of all adoptable pets for that shelter' do
      northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
      pancho = Pet.create!(adoptable: true, age: 5, breed: "Chiuahua", name: "Pancho", shelter_id: northshore.id)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: northshore.id)
      animal = Pet.create!(adoptable: false, age: 12, breed: "Muppet", name: "Animal", shelter_id: northshore.id)
      kermit = Pet.create!(adoptable: true, age: 9, breed: "Frog", name: "Kermit", shelter_id: northshore.id)

      visit "/admin/shelters/#{northshore.id}"

      expect(page).to have_content("Statistics")
      expect(page).to have_content("Average age of all adoptable pets")
      
      within "#average_age-#{northshore.id}" do
        expect(page).to have_content(5)
      end
      save_and_open_page
    end
  end
end