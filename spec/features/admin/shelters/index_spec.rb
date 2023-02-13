require 'rails_helper'

RSpec.describe "/admin/shelters" do
  let!(:shelter_1) {Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: "1") }
  let!(:shelter_2) {Shelter.create!(name: "Max Fund", foster_program: true, city: "Aurora", rank: "2") }
  let!(:shelter_3) {Shelter.create!(name: "Human Society", foster_program: false, city: "Denver", rank: "3") }
  
  let!(:pet_1) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 6, breed: "Soft Coated Wheaton Terrier", name: "Larry") }
  
  let!(:application_1) { Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "Pending", pets_on_app: pet_1.name) }
  let!(:application_2) { Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "In Progress", pets_on_app: pet_1.name) }

  let!(:application_pet) { ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id) }

  describe "When I visit the admin shelter index ('/admin/shelters')" do
    it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
      
      visit '/admin/shelters'
      
      expect(page).to have_content(shelter_1.name)

      expect(shelter_2.name).to appear_before(shelter_1.name)
      expect(shelter_3.name).to appear_before(shelter_1.name)
    end

    it "I see a section for 'Shelters with Pending Applications', and name of every shelter with pending application" do

      visit '/admin/shelters'

      
      within("div#pending-applications") do 
        expect(page).to have_content("Shelters with Pending Applications")
        expect(page).to have_content(shelter_1.name)
        expect(page).to_not have_content(shelter_3.name)
      end
    end
  end
end