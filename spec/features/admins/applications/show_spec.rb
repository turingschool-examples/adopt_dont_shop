require 'rails_helper'

RSpec.describe 'admin_applications show page' do
  describe 'as a visitor' do
    describe 'when i visit an admin_application show page' do
      it 'for every pet, i see a button to approve the application for that specific pet' do
        application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet_1 = application.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_2 = application.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_3 = application.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/admin/applications/#{application.id}"

        within "#pet-#{pet_1.id}" do
          expect(page).to have_button("Approve")
        end

        within "#pet-#{pet_2.id}" do
          expect(page).to have_button("Approve")
        end

        within "#pet-#{pet_3.id}" do
          expect(page).to have_button("Approve")
          click_button "Approve"
        end

        expect(current_path).to eq("/admin/applications/#{application.id}")

        within "#pet-#{pet_3.id}" do
          expect(page).not_to have_button("Approve")
          expect(page).to have_content("Approved!")
        end
      end

      it 'for every pet, i see a button to reject the application for that specific pet' do
        application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet_1 = application.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_2 = application.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_3 = application.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/admin/applications/#{application.id}"

        within "#pet-#{pet_1.id}" do
          expect(page).to have_button("Reject")
        end

        within "#pet-#{pet_2.id}" do
          expect(page).to have_button("Reject")
        end

        within "#pet-#{pet_3.id}" do
          expect(page).to have_button("Reject")
          click_button "Reject"
        end

        expect(current_path).to eq("/admin/applications/#{application.id}")

        within "#pet-#{pet_3.id}" do
          expect(page).not_to have_button("Reject")
          expect(page).to have_content("Rejected!")
        end
      end
    end
  end
end
