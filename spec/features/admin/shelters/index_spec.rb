require 'rails_helper' 

RSpec.describe 'the admin shelters index' do 

    it 'lists Shelters in reverse alphabetical order when visited by admin' do
        shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

        visit '/admin/shelters' 

        expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
        expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    end

    it 'lists shelters with pending applications' do 
        Shelter.destroy_all
        Pet.destroy_all
        shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        
        pet1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        pet2 = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        pet3 = shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

        app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I love animals!', status: 1)

        # create row in application_pet table 
        app_pet1 = ApplicationPet.create!(application: app, pet: pet1, status: 'Pending')
        app_pet2 = ApplicationPet.create!(application: app, pet: pet3, status: 'Pending')
 
        visit '/admin/shelters' 
        save_and_open_page

        within '#pending' do 
            expect(page).to have_content('Shelters with Pending Applications')
            expect(page).to have_content('Aurora shelter')
            expect(page).to have_content('Fancy pets of Colorado')
            expect(page).to_not have_content('RGV animal shelter')
        end
    end
end

