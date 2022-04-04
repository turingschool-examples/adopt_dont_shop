require "rails_helper"

RSpec.describe 'admin_shelters index page' do
  describe 'as a visitor' do
    describe 'when i visit the admin_shelters index' do
      it 'i see all shelters in the system listed in reverse alphabetical order' do
        shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

        visit "/admin/shelters"

        expect(shelter_2.name).to appear_before(shelter_3.name)
        expect(shelter_3.name).to appear_before(shelter_1.name)
      end

      it 'i see a section for shelters with pending applications' do
        shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        application_1 = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'Pending')
        pet_1 = application_1.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        pet_2 = application_1.pets.create(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        application_2 = Application.create!(name: 'James', address: '1259 N Clarkson St.', city: 'Denver', state: 'CO', zipcode: '80218', description: "Love dogs.", status: 'Pending')
        pet_3 = application_2.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_2.id)
        application_3 = Application.create!(name: 'James', address: '1259 N Clarkson St.', city: 'Denver', state: 'CO', zipcode: '80218', description: "Love dogs.", status: 'In-progress')
        pet_4 = application_3.pets.create!(name: 'Brian', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_3.id)

        visit "/admin/shelters"

        within "#pending_shelters" do
          expect(page).to have_content(shelter_1.name)
          expect(page).to have_content(shelter_2.name)
          expect(page).not_to have_content(shelter_3.name)
        end
      end

      it 'i see that the pending shelters with pending apps are listed alphabetically' do
        shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        application_1 = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'Pending')
        pet_1 = application_1.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        pet_2 = application_1.pets.create(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        application_2 = Application.create!(name: 'James', address: '1259 N Clarkson St.', city: 'Denver', state: 'CO', zipcode: '80218', description: "Love dogs.", status: 'Pending')
        pet_3 = application_2.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_2.id)
        application_3 = Application.create!(name: 'James', address: '1259 N Clarkson St.', city: 'Denver', state: 'CO', zipcode: '80218', description: "Love dogs.", status: 'Pending')
        pet_4 = application_3.pets.create!(name: 'Brian', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_3.id)

        visit "/admin/shelters"

        within "#pending_shelters" do
          expect(shelter_1.name).to appear_before(shelter_3.name)
          expect(shelter_3.name).to appear_before(shelter_2.name)
        end
      end
    end
  end
end
