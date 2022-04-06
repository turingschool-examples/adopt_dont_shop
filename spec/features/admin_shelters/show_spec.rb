require 'rails_helper'


RSpec.describe 'Admin Shelter Show Page' do
  before do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_2.pets.create(name: 'Trust', breed: 'sphynx', age: 4, adoptable: false)

    @app_1 = Application.create!(name: 'bob', address: '100 main street, Aurora, CO, 80014', description: 'I love dogs', pet_names: 'Mr. Pirate, Champ, Pixie', status: 1)
    @app_3 = Application.create!(name: 'Jim', address: '245 oak lane, longmont, CO, 80045', description: 'Best home ever', pet_names: 'Charlie, Gypsy, Lucille Bald', status: 1)
    @app_2 = Application.create!(name: 'sumbit', address: '321 hill ave, Denver, CO, 80021', description: "", pet_names: "", status: 0)

    ApplicationPet.create!(application: @app_1, pet: @pet_1)
    ApplicationPet.create!(application: @app_3, pet: @pet_3)
    ApplicationPet.create!(application: @app_2, pet: @pet_4)

    visit "/admin/shelters/#{@shelter_1.id}"
  end

  describe 'As a visitor' do
    describe 'When I visit an admin shelter show page' do
      it 'Then I see that shelters name and full address' do
        save_and_open_page
        within "#shelter-#{@shelter_1.id}" do
          expect(page).to have_content("#{@shelter_1.name}")
          expect(page).to have_content("#{@shelter_1.full_address}")
        end
      end
    end
  end
end