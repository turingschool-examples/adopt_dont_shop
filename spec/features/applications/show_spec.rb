require 'rails_helper'

RSpec.describe 'the application show page' do
  describe 'as a visitor' do
    let(:shelter) { Shelter.create!(
      name: 'Test Shelter',
      rank: 1,
      city: 'Denver'
    ) }

    let(:fluffy) { shelter.pets.create!(
      name: 'Fluffy',
      age: 2,
    )}

    let(:buffy) { shelter.pets.create!(
      name: 'Buffy',
      age: 6,
    )}

    let(:application) { Application.create!(
      name: 'CatMan',
      address: '123 Main Street',
      city: 'Denver',
      state: 'CO',
      zip: '80204',
      description: 'I WANT ALL THE CATS!'
    ) }

    it 'shows the applicant info, description, pet names, and status' do
      application.pets << fluffy
      application.pets << buffy
      visit "/applications/#{application.id}"

      expect(page).to have_content 'Name: CatMan'
      expect(page).to have_content 'Address: 123 Main Street'
      expect(page).to have_content 'City: Denver'
      expect(page).to have_content 'State: CO'
      expect(page).to have_content 'Zip: 80204'
      expect(page).to have_content 'I WANT ALL THE CATS!'
      expect(page).to have_content 'Fluffy'
      expect(page).to have_content 'Buffy'
      expect(page).to have_content 'Application Status: Pending'
    end

    it 'links to each pets show page' do
      application.pets << fluffy
      visit "applications/#{application.id}"
      click_on 'Fluffy'

      expect(current_path).to eq "/pets/#{fluffy.id}"
    end

    describe 'when the application has not been submitted' do
      describe 'Pet Lookup' do
        it 'has a search bar to lookup pets by name' do
          visit "applications/#{application.id}"

          expect(page).to have_button 'Search'
        end

        it 'lists partial matches as search results' do
          shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
          pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
          pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
          pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

          visit "/applications/#{application.id}"

          fill_in 'Search', with: "Ba"
          click_on("Search")

          # how to display search results on this page?
          expect(current_path).to eq "/applications/#{application.id}"
          expect(page).to have_content(pet_1.name)
          expect(page).to have_content(pet_2.name)
          expect(page).to_not have_content(pet_3.name)
        end
      end

      it 'pets can be added to the application' do
      end
    end

    describe 'when the application has been submitted' do
    end
  end
end
