require 'rails_helper'

RSpec.describe Application do
  describe 'new applications' do

    describe 'as a visitor' do

      it 'visit pet index page, click link to start an application' do
        Application.destroy_all
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

        visit "/pets"


        click_link "Start an Application"
        expect(current_path).to eq("/applications/new")

        fill_in 'Name', with: 'Barry Bonds'
        fill_in 'Address', with: '513 Maggie Lane, Evergreen, CO, 80439'
        click_on 'Submit'
        # expect(current_path).to eq("/applications/7")


        expect(page).to have_content("Name: Barry Bonds")
        expect(page).to have_content("Address: 513 Maggie Lane, Evergreen, CO, 80439")
        expect(page).to have_content("Description: ")
        expect(page).to have_content("Pet Name(s): ")
        expect(page).to have_content("Status: in_progress")
      end

      it 'When I visit to applications page and fail to fill in any of the fields' do
        visit "/applications/new"
        # fill_in 'Name', with: 'Barry Bonds'
        # fill_in 'Address', with:
        click_on 'Submit'
        expect(current_path).to eq("/applications/new")
        expect(page).to have_content('Please fill in all fields')
      end



    end


  end
end
