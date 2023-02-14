require 'rails_helper'

RSpec.describe 'visiting admin app show page' do
  let!(:shelter_1) {Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: "1") }
  
  let!(:pet_1) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 6, breed: "Soft Coated Wheaton Terrier", name: "Larry") }
  let!(:pet_2) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 1, breed: "Boston Terrier", name: "Fred") }
  
  let!(:application_1) { Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "Pending", pets_on_app: [pet_1.name, pet_2.name]) }
  let!(:application_2) { Application.create!(name: "Holly", street_address: "2307 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "In Progress", pets_on_app: pet_1.name) }

  let!(:application_pet) { ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id) }
  let!(:application_pet_2) { ApplicationPet.create!(pet_id: pet_2.id, application_id: application_1.id) }


  describe 'For every pet that the application is for, I see a button to approve the application for that specific pet' do
    describe 'when I click that button' do
      it "taken back to the admin app show page, next to pet that I approved, no button and isntead indicator they've been approved" do
        visit "/admin/applications/#{application_1.id}"

        expect(page).to have_button("Approve #{pet_1.name}")
        expect(page).to have_button("Approve #{pet_2.name}")
        
        click_on "Approve #{pet_1.name}"

        expect(current_path).to eq("/admin/applications/#{application_1.id}")
        expect(page).to_not have_button("Approve #{pet_1.name}")
        expect(page).to have_button("Approve #{pet_2.name}")

        expect(page).to have_content("#{pet_1.name}")
        expect(page).to have_content("#{pet_2.name}")

        expect(page).to have_content("Pet has been approved")
      end
    end
  end

  describe 'For every pet that the application is for, I see a button to reject the application for that specific pet' do
    describe 'when I click that button' do
      it "taken back to the admin app show page, next to pet that I rejected, no button and isntead indicator they've been rejected" do
        visit "/admin/applications/#{application_1.id}"

        expect(page).to have_button("Reject #{pet_1.name}")
        expect(page).to have_button("Reject #{pet_2.name}")
        
        click_on "Reject #{pet_1.name}"

        expect(current_path).to eq("/admin/applications/#{application_1.id}")
        expect(page).to_not have_button("Reject #{pet_1.name}")
        expect(page).to have_button("Reject #{pet_2.name}")

        expect(page).to have_content("#{pet_1.name}")
        expect(page).to have_content("#{pet_2.name}")

        expect(page).to have_content("Pet has been rejected")
      end
    end
  end
end