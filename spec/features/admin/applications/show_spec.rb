require 'rails_helper'

RSpec.describe 'visiting admin app show page' do
  let!(:shelter_1) {Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: "1") }
  
  let!(:pet) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 6, breed: "Soft Coated Wheaton Terrier", name: "Larry") }
  
  let!(:application_1) { Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "Pending", pets_on_app: pet.name) }
  let!(:application_2) { Application.create!(name: "Holly", street_address: "2307 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "In Progress", pets_on_app: pet.name) }

  let!(:application_pet) { ApplicationPet.create!(pet_id: pet.id, application_id: application_1.id) }


  describe 'For every pet that the application is for, I see a button to approve the application for that specific pet' do
    describe 'when I click that button' do
      it "taken back to the admin app show page, next to pet that I approved, no button and isntead indicator they've been approved" do
        visit "/admin/applications/#{application_1.id}"

        expect(page).to have_button("Approve Application")
        
        click_on "Approve Application"

        expect(current_path).to eq("/admin/applications/#{application_1.id}")
        expect(page).to_not have_button("Approve Application")
        expect(page).to have_content("#{pet.name}")
        expect(page).to have_content("You've been approved")
      end
    end
  end
end