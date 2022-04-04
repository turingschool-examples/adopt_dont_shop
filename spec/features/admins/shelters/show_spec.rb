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
      end
    end
  end
end
