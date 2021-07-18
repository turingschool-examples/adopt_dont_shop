require 'rails_helper'

RSpec.describe 'Application show page' do
  before (:each) do
    @furry = Shelter.create!(name:'Furrry Shelter', foster_program: true, city: 'New Orleans', rank: 5)

    @bruce = @furry.pets.create!(name: 'Bruce', age: 3, adoptable: true, breed: 'black lab')
    @lana = @furry.pets.create!(name: 'Lana', age: 1, adoptable: true, breed: 'short-haired')
    @doc = @furry.pets.create!(name: 'Doc', age: 8, adoptable: true, breed: 'schnauzer')
    @doctor = @furry.pets.create!(name: 'Doctor', age: 9, adoptable: true, breed: 'pomeranian')

    @application1 = Application.create!(name: 'Carina', street_address: '455 Cool Street', city: 'Portland', state: 'OR', zip_code: 23392, status: 'In Progress')

    @application2 = Application.create!(name: 'Evan', street_address: '1234 Sparky Lane', city: 'Portland', state: 'OR', zip_code: 23392, home_description: 'I like playing and throwing ball with dogs', status: 'In Progress')

    @application1.pets << [@lana, @doc]
  end

  describe 'visitor' do

    it 'displays application attributes' do
      visit "/applications/#{@application1.id}"

      expect(page).to have_content(@application1.name)
      expect(page).to have_content("Address:\n#{@application1.street_address}, #{@application1.city}, #{@application1.state} #{@application1.zip_code}")
      expect(page).to have_content("Pet(s) to adopt:\n#{@lana.name}\n#{@doc.name}")
      expect(page).to have_content("Status:\n#{@application1.status}")
    end

    describe 'search' do
      it 'can search pets for an application' do
        visit "/applications/#{@application2.id}"

        expect(page).to_not have_content('Doc')

        fill_in(:search, with: 'Doc')
        click_button('Search')

        expect(current_path).to eq("/applications/#{@application2.id}")
        expect(page).to have_content('Doc')
      end

      it 'can retrieve partial matches for pets' do
        visit "/applications/#{@application2.id}"

        expect(page).to_not have_content('Doc')
        expect(page).to_not have_content('Doctor')

        fill_in(:search, with: 'Doc')
        click_button('Search')

        expect(current_path).to eq("/applications/#{@application2.id}")
        expect(page).to have_content('Doc')
        expect(page).to have_content('Doctor')
      end

      it 'searches are case insensitive' do
        visit "/applications/#{@application2.id}"

        expect(page).to_not have_content('Doc')
        expect(page).to_not have_content('Doctor')

        fill_in(:search, with: 'doC')
        click_button('Search')

        expect(current_path).to eq("/applications/#{@application2.id}")
        expect(page).to have_content('Doc')
        expect(page).to have_content('Doctor')
      end
    end

    describe 'application edits and submission' do
      it 'can add a pet to the application' do
        visit "/applications/#{@application2.id}"

        fill_in(:search, with: 'Doc')
        click_button('Search')

        within(:css, ".result##{@doc.id}") do
          click_on('Adopt this Pet')
        end

        expect(current_path).to eq("/applications/#{@application2.id}")
        within(:css, ".adopt##{@doc.id}") do
          expect(page).to have_content('Doc')
        end

        fill_in(:search, with: 'Bruce')
        click_button('Search')

        within(:css, ".result##{@bruce.id}") do
          click_on('Adopt this Pet')
        end

        expect(current_path).to eq("/applications/#{@application2.id}")
        within(:css, ".adopt##{@doc.id}") do
          expect(page).to have_content('Doc')
        end
        within(:css, ".adopt##{@bruce.id}") do
          expect(page).to have_content('Bruce')
        end
      end

      it 'can submit application when more than 1 pet added' do
        visit "/applications/#{@application1.id}"

        fill_in(:home_description, with: 'I take lots of walks.')
        click_button('Submit Application')

        expect(current_path).to eq("/applications/#{@application1.id}")
        expect(page).to have_content("Status:\nPending")
        expect(page).to have_content(@lana.name)
        expect(page).to have_content(@doc.name)
        expect(page).to_not have_content(@bruce.name)

        expect(page).to_not have_content('Why I would make a good owner for these pet(s)')
      end

      it 'cannot submit an application if there are no pets added' do
        visit "/applications/#{@application2.id}"

        expect(page).to_not have_content('Why I would make a good owner for these pet(s):')
        expect(page).to_not have_content('Submit Application')
      end
    end
  end
end
