require 'rails_helper'

RSpec.describe 'application show page' do
  describe 'as a visitor' do
    describe 'when i visit an application show page' do
      before do
        @shelter = create :shelter
        @pet1 = create :pet, { shelter_id: @shelter.id }
        @pet2 = create :pet, { shelter_id: @shelter.id }
        @pet3 = create :pet, { shelter_id: @shelter.id }
        @application = create :application

        @application.pets << @pet1
        @application.pets << @pet2
        visit application_path(@application)
      end

      it 'i see all the attributes of the application including pets' do
        expect(page).to have_content(@application.name)
        expect(page).to have_content(@application.address)
        expect(page).to have_content(@application.city)
        expect(page).to have_content(@application.state)
        expect(page).to have_content(@application.zip)
        expect(page).to have_content(@application.description)
        expect(page).to have_content(@application.status)
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet2.name)
        expect(page).to_not have_content(@pet3.name)
      end

      it 'pet names are links to their show page' do
        click_link @pet1.name
        expect(current_path).to eq("/pets/#{@pet1.id}")
      end

      it 'i search for pets by name' do
        fill_in :search, with: @pet3.name
        click_button 'Search'

        expect(current_path).to eq(application_path(@application))
        expect(page).to have_link(@pet3.name)
      end

      it 'i can add pet to application with button' do
        fill_in :search, with: @pet3.name
        click_button 'Search'

        within("#pet-#{@pet3.id}") do
          click_button 'Add to this Application'
        end

        expect(current_path).to eq(application_path(@application))
        expect(page).to have_content(@pet3.name)
      end
    end
  end
end

# - names of all pets that this application is for (all names of pets should be links to their show page)
