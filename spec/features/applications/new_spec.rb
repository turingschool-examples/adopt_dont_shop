require 'rails_helper'

RSpec.describe 'the application new page' do
    describe 'the application new page' do
        it "has a link on the pet index to make an application" do
            visit "/pets"

            click_on('Start an Application')

            expect(current_path).to eq('/applications/new')
        end

        it 'renders the new form' do
            visit '/applications/new'

            expect(page).to have_content('New Application')
            expect(find('form')).to have_content('Name')
            expect(find('form')).to have_content('Street Address')
            expect(find('form')).to have_content('City')
            expect(find('form')).to have_content('State')
            expect(find('form')).to have_content('Zip Code')
        end
end
    describe 'Application creation' do
        it 'Application create with valid data' do
            visit '/applications/new'

            fill_in('name', with: 'new person')
            fill_in('street_address', with: '456 pickup st')
            fill_in('city', with: 'Bridgeport')
            fill_in('state', with: 'CT')
            fill_in('zipcode', with: '12345')

            click_on('Submit')
            application = Application.last

            expect(current_path).to eq("/applications/#{application.id}")
            expect(page).to have_content('new person')
            expect(page).to have_content('456 pickup st')
            expect(page).to have_content('Bridgeport')
            expect(page).to have_content('CT')
            expect(page).to have_content('12345')
            expect(page).to have_content('Description Needed')
            expect(page).to have_content('In Progress')
        end

        it 'Application create gives warning for invalid data' do
            visit '/applications/new'

            click_on('Submit')

            expect(current_path).to eq('/applications/new')
            expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zipcode can't be blank")
        end
    end
end
