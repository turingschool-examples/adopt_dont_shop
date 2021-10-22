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
  end
end
