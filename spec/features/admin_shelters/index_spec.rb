require 'rails_helper'

RSpec.describe 'Admin Shelter Index Page' do
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

    visit '/admin/shelters'
  end
  describe 'As a visitor' do
    describe 'When I visit the admin shelter index' do
      it 'Then I see all shelters in the system listed in reverse alphabetical order' do
        within "#shelter-#{@shelter_2.id}" do
          expect(page).to have_content("#{@shelter_2.name}")
          expect(page).to have_content("#{@shelter_2.city}")
          expect(page).to have_content("#{@shelter_2.foster_program}")
          expect(page).to have_content("#{@shelter_2.rank}")
          expect(page).to_not have_content("#{@shelter_3.name}")
          expect(page).to_not have_content("#{@shelter_1.name}")
        end
        within "#shelter-#{@shelter_3.id}" do
          expect(page).to have_content("#{@shelter_3.name}")
          expect(page).to have_content("#{@shelter_3.city}")
          expect(page).to have_content("#{@shelter_3.foster_program}")
          expect(page).to have_content("#{@shelter_3.rank}")
          expect(page).to_not have_content("#{@shelter_2.name}")
          expect(page).to_not have_content("#{@shelter_1.name}")
        end
        within "#shelter-#{@shelter_1.id}" do
          expect(page).to have_content("#{@shelter_1.name}")
          expect(page).to have_content("#{@shelter_1.city}")
          expect(page).to have_content("#{@shelter_1.foster_program}")
          expect(page).to have_content("#{@shelter_1.rank}")
          expect(page).to_not have_content("#{@shelter_3.name}")
          expect(page).to_not have_content("#{@shelter_2.name}")
        end
      end
      it 'Then I see a section for Shelters with Pending Applications' do
        within("#pending_application") do
          expect(page).to have_content("Shelters with Pending Applications:")
        end
      end
      it 'And in this section I see the name of every shelter that has a pending application' do
        within("#pending_application") do
          expect(page).to have_content("#{@shelter_1.name}")
          expect(page).to have_content("#{@shelter_3.name}")
          expect(page).to_not have_content("#{@shelter_1.city}")
          expect(page).to_not have_content("#{@shelter_1.foster_program}")
          expect(page).to_not have_content("#{@shelter_1.rank}")
          expect(page).to_not have_content("#{@shelter_2.name}")
        end
      end
      it 'Then I see that every shelter name is a link' do
        within "#shelter-#{@shelter_2.id}" do
          expect(page).to have_selector(:link_or_button, "#{@shelter_2.name}")
          expect(page).to_not have_selector(:link_or_button, "#{@shelter_1.name}")
        end
        within "#shelter-#{@shelter_3.id}" do
          expect(page).to have_selector(:link_or_button, "#{@shelter_3.name}")
        end
      end
      it 'When I click one of these links I am taken to that shelters show page' do
        within "#shelter-#{@shelter_1.id}" do
          click_link "#{@shelter_1.name}"
          expect(current_path).to eq("/admin/shelters/#{@shelter_1.id}")
          expect(current_path).to_not eq("/admin/shelters/#{@shelter_2.id}")
        end
      end
    end
  end
end
