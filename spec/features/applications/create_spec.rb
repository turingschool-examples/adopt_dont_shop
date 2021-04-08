require 'rails_helper'

RSpec.describe 'pet creation' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

  describe 'New Application' do
    context 'given valid data' do
      it 'renders the new form' do
        visit "/applications/new"

        expect(page).to have_content("Application")
        expect(find('form')).to have_content("Name:")
        expect(find('form')).to have_content("Street Address:")
        expect(find('form')).to have_content("City:")
        expect(find('form')).to have_content("State:")
        expect(find('form')).to have_content("Zip Code:")

        fill_in 'Name:', with: 'Wesley Snipes'
        fill_in 'Street Address:', with: '1678 Oroya Drive'
        fill_in 'City:', with: 'Albuquerque'
        fill_in 'State:', with: 'New Mexico'
        fill_in 'Zip Code:', with: '87962'

        click_on 'Submit'
        wesley = Application.all.last
        expect(current_path).to eq("/applications/#{wesley.id}")

        expect(page).to have_content(wesley.name)
        expect(page).to have_content(wesley.street_address)
        expect(page).to have_content(wesley.city)
        expect(page).to have_content(wesley.state)
        expect(page).to have_content(wesley.zip_code)

        expect(page).to have_content("In Progress")
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/applications/new"

        click_button 'Submit'
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Zip code is not a number")
      end
    end
  end
end
