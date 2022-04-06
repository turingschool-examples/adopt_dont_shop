require 'rails_helper'

RSpec.describe 'admin_shelters show page' do
  describe 'as a visitor' do
    describe 'when i visit an admin shelter show page' do
      describe 'i see a section for statistics' do
        it 'and it contains the average age of all adoptable pets for that shelter' do
          shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
          shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
          pet_1 = shelter_1.pets.create(name: 'Scrappy', age: 4, breed: 'Great Dane', adoptable: true)
          pet_2 = shelter_1.pets.create(name: 'Sparky', age: 6, breed: 'Great Dane', adoptable: true)
          pet_3 = shelter_1.pets.create!(name: 'Spot', age: 9, breed: 'Great Dane', adoptable: false)
          pet_4 = shelter_2.pets.create!(name: 'Brian', age: 3, breed: 'Great Dane', adoptable: true)

          visit "/admin/shelters/#{shelter_1.id}"

          within "#statistics" do
            expect(page).to have_content("Average Pet Age: 5")
          end
        end

        it 'and it contains the count of adoptable pets for that shelter' do
          shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
          shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
          pet_1 = shelter_1.pets.create(name: 'Scrappy', age: 4, breed: 'Great Dane', adoptable: true)
          pet_2 = shelter_1.pets.create(name: 'Sparky', age: 6, breed: 'Great Dane', adoptable: true)
          pet_3 = shelter_1.pets.create!(name: 'Spot', age: 9, breed: 'Great Dane', adoptable: false)
          pet_4 = shelter_2.pets.create!(name: 'Brian', age: 3, breed: 'Great Dane', adoptable: true)

          visit "/admin/shelters/#{shelter_1.id}"

          within "#statistics" do
            expect(page).to have_content("Number of Adoptable Pets: 2")
          end
        end

        it 'displays a section titled Action Required that lists the pets with pending applicaitons, not approved or rejected' do
          application_1 = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'Pending')
          application_2 = Application.create!(name: 'John', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In Progress')
          shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
          shelter_2 = Shelter.create(name: 'Known Building', city: 'Irvine CA', foster_program: false, rank: 9)
          pet_1 = application_1.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
          pet_2 = application_1.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
          pet_3 = application_1.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
          pet_4 = application_1.pets.create!(name: 'Rupert', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
          pet_5 = application_2.pets.create!(name: 'Charles', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_2.id)

          visit "/admin/applications/#{application_1.id}"

          within "#pet-#{pet_3.id}" do
            click_button "Approve"
          end

          within "#pet-#{pet_4.id}" do
            click_button "Reject"
          end

          visit "/admin/shelters/#{shelter.id}"

          within "#action_required" do
            expect(page).to have_content("Scrappy")
            expect(page).to have_content("Sparky")
            expect(page).to_not have_content("Spot")
            expect(page).to_not have_content("Rupert")
            expect(page).to_not have_content("Charles")
          end
        end

        it 'and it contains the count of adopted pets for that shelter' do
          application_1 = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In Progress')
          shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
          pet_1 = application_1.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
          pet_2 = application_1.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
          pet_3 = Pet.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

          visit "/admin/applications/#{application_1.id}"

          within "#pet-#{pet_1.id}" do
            click_button "Approve"
          end

          within "#pet-#{pet_2.id}" do
            click_button "Approve"
          end

          visit "/admin/shelters/#{shelter.id}"

          within "#statistics" do
            expect(page).to have_content("Number of Adopted Pets: 2")
          end
        end

        it 'i see the shelters name and full address' do
          shelter = Shelter.create(name: 'Mystery Building', address: "22 Acacia Ave.", city: 'New York', state: "NY", zip_code: "10501", foster_program: false, rank: 9)

          visit "/admin/shelters/#{shelter.id}"

          expect(page).to have_content("Mystery Building")
          expect(page).to have_content("22 Acacia Ave. New York, NY 10501")
        end
      end
    end
  end
end
