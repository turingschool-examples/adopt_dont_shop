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

      it 'application and rejection buttons work together' do
        application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet_1 = application.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_2 = application.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_3 = application.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/admin/applications/#{application.id}"

        within "#pet-#{pet_1.id}" do
          click_button "Approve"
        end

        within "#pet-#{pet_2.id}" do
          click_button "Reject"
        end

        within "#pet-#{pet_1.id}" do
          expect(page).to have_content("Approved!")
        end

        within "#pet-#{pet_2.id}" do
          expect(page).to have_content("Rejected!")
        end

        within "#pet-#{pet_3.id}" do
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        end
      end

      it 'approval and rejection for one application does not affect other applications' do
        application_1 = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet_1 = application_1.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_2 = application_1.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_3 = application_1.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        application_2 = pet_1.applications.create!(name: 'James', address: '1259 N Clarkson St.', city: 'Denver', state: 'CO', zipcode: '80218', description: "Love dogs!", status: 'In-progress')
        application_3 = pet_2.applications.create!(name: 'Ian', address: '4690 S Garrison St.', city: 'Denver', state: 'CO', zipcode: '80123', description: "Love dogs!", status: 'In-progress')

        visit "/admin/applications/#{application_1.id}"

        within "#pet-#{pet_1.id}" do
          click_button "Approve"
        end

        within "#pet-#{pet_2.id}" do
          click_button "Reject"
        end

        visit "/admin/applications/#{application_2.id}"

        within "#pet-#{pet_1.id}" do
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
          expect(page).not_to have_content("Approved!")
          expect(page).not_to have_content("Rejected!")
        end

        visit "/admin/applications/#{application_3.id}"

        within "#pet-#{pet_2.id}" do
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
          expect(page).not_to have_content("Approved!")
          expect(page).not_to have_content("Rejected!")
        end
      end

      it 'shows that the application has been approved if all pets are approved' do
        application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet_1 = application.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_2 = application.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet_3 = application.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/admin/applications/#{application.id}"

        within "#pet-#{pet_1.id}" do
          click_button "Approve"
        end

        within "#pet-#{pet_2.id}" do
          click_button "Approve"
        end

        within "#pet-#{pet_3.id}" do
          click_button "Approve"
        end

        expect(current_path).to eq("/admin/applications/#{application.id}")
        expect(page).to have_content("Application Status: Approved!")
      end
    end
  end
end
