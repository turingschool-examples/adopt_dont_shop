require 'rails_helper'

RSpec.describe 'the application show page' do
  let(:shelter)     { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:fluffy)     { shelter.pets.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Fluffy')}
  let!(:buffy)      { shelter.pets.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Buffy')}
  let!(:elle)       { shelter.pets.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle') }
  let(:application) { Application.create(name: 'CatMan', address: '123 Main Street', city: 'Denver', state: 'CO', zip: '80204', description: 'I WANT ALL THE CATS!') }

  describe 'as a visitor' do
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

    describe 'when the application has not been submitted' do
      describe 'Pet Lookup' do
        it 'has a search bar to lookup pets by name' do
          visit "applications/#{application.id}"

          expect(page).to have_button 'Search'
        end

        it 'lists partial matches as search results' do
          visit "/applications/#{application.id}"

          fill_in 'Search', with: "buf"
          click_on("Search")

          expect(current_path).to eq "/applications/#{application.id}"
          expect(page).to_not have_content(fluffy.name)
          expect(page).to have_content(buffy.name)
          expect(page).to_not have_content(elle.name)
        end
      end

      it 'pets can be added to the application' do
        visit "/applications/#{application.id}"
        fill_in 'Search', with: "buf"
        click_on("Search")

        click_on('Adopt this Pet')

        expect(current_path).to eq "/applications/#{application.id}"
        expect(page).to have_content 'Buffy'
      end

      describe 'when no pets have been added' do
        it 'cannot be submitted' do
          visit "/applications/#{application.id}"

          expect(page).to_not have_content 'Submit'
        end
      end

      describe 'when one or more pets have been added' do
        it 'can be submitted' do
          visit "/applications/#{application.id}"
          fill_in 'Search', with: "buf"
          click_on("Search")
          click_on('Adopt this Pet')

          expect(page).to have_button 'Submit'

          click_on 'Submit'

          expect(current_path).to eq "/applications/#{application.id}"
        end
      end
    end

    describe 'when the application has been submitted' do
      it 'submitting removes the ability to add more pets' do
        visit "/applications/#{application.id}"
        fill_in 'Search', with: "buf"
        click_on("Search")
        click_on('Adopt this Pet')
        click_on 'Submit'

        expect(page).to_not have_content 'Search'
        expect(page).to have_content 'Buffy'
        expect(page).to have_content 'Pending'
      end
    end
  end
end
