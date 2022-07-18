require 'rails_helper'

RSpec.describe Applicant do
  describe 'applicant#new' do
      it 'can create new applicants' do
        Applicant.destroy_all
        shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)

        visit "/pets"
        click_link("Start an Application", match: :first)

        expect(current_path).to eq("/applicants/new")

        fill_in 'Name', with: "Sherr", exact: true
        fill_in 'Street address', with: "places", exact: true
        fill_in 'City', with: "cities", exact: true
        fill_in 'State', with: "states", exact: true
        fill_in 'Zip code', with: "00000", exact: true
        fill_in 'Description', with: "reasons", exact: true

        click_on('Submit')

        expect(page).to have_current_path("/applicants/#{Applicant.last.id}")

        expect(page).to have_content('Sherr')
        expect(page).to have_content('places')
        expect(page).to have_content('cities')
        expect(page).to have_content('states')
        expect(page).to have_content('00000')
        expect(page).to have_content('reasons')
        expect(page).to have_content('pending')
      end
  end

  describe 'submitting an unfinish application' do
    it 'unfinished applications return user back to application form' do
      Applicant.destroy_all
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)

      visit "/applicants/new"

      fill_in 'Name', with: "Sherri", exact: true
      #fill_in 'Street address', with: 'places' , exact: true
      fill_in 'City', with: "cities", exact: true
      fill_in 'State', with: "states", exact: true
      fill_in 'Zip code', with: "00000", exact: true
      fill_in 'Description', with: "reasons", exact: true

      click_on('Submit')
      expect(current_path).to eq("/applicants/new")
      expect(page).to have_content("Please fill in all the required fields")

      fill_in 'Name', with: "Sherri", exact: true
      fill_in 'Street address', with: "places", exact: true
      fill_in 'City', with: "cities", exact: true
      fill_in 'State', with: "states", exact: true
      fill_in 'Zip code', with: "00000", exact: true
      fill_in 'Description', with: "reasons", exact: true

      click_on('Submit')
      expect(current_path).to eq("/applicants/#{Applicant.last.id}")
      expect(page).to have_content("places")
    end
  end
end


