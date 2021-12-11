require 'rails_helper'

RSpec.describe 'Create Application' do

    before(:each) do
        @helping_hounds = Shelter.create!(name: 'Helping Hounds', city: 'Syracuse, NY', foster_program: false, rank: 9)
        @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @helping_hounds.id)
    end

    describe 'the pet index' do
        it 'has a link to apply to adopt' do
            visit "/pets"
        
            click_link("Start An Adoption Application")
        
            expect(current_path).to eq("/applications/new")
        end
    end

    describe 'the new form' do
        it 'renders the new form' do
            visit "/applications/new"

            expect(page).to have_content('New Application')
            expect(find('form')).to have_content('Name')
            expect(find('form')).to have_content('Address')
            expect(find('form')).to have_content('City')
            expect(find('form')).to have_content('State')
            expect(find('form')).to have_content('Zipcode')
            expect(find('form')).to have_content('Reason')
        end
    end

    describe 'for submission' do 
        it 'accepts submission of a new application' do
            visit '/applications/new'

            fill_in :name, with: "Jane Doe"
            fill_in :address, with: "894 Slate Lick Road"
            fill_in :city, with: "Kittanning"
            fill_in :state, with: "PA"
            fill_in :zip, with: "15674"

            click_button "Save"
            expect(page).to have_content("Thanks for applying to save a life!")
            expect(page).to have_content("Jane Doe")
            expect(page).to have_content("894 Slate Lick Road")
            expect(page).to have_content("Kittanning")
            expect(page).to have_content("PA")
            expect(page).to have_content("15674")
            expect(page).to have_content("in progress")
            # how else to test that this redirected to the show page...?
        end
    end
end
