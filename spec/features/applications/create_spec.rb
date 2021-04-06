require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it 'renders the new form' do
    visit '/applications/new'

    expect(page).to have_content('New Application')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip code')
  end
end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates a new application' do

        # application = Application.create(name: '', street_address: '', city: '', state: '', status: '')

        visit '/applications/new'

        fill_in 'Name', with: 'Bob Ross'
        fill_in 'Street address', with: 'Downing St'
        fill_in 'City', with: 'Denver'
        select 'CO', :from => 'State'
        fill_in 'Zip code', with: '80211'
        click_button 'Submit'

        # expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content('Bob Ross')
        expect(page).to have_content('Downing St')
        expect(page).to have_content('Denver')
        expect(page).to have_content('CO')
        expect(page).to have_content('80211')
        expect(page).to have_content('In Progress')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit '/applications/new'
        click_button 'Submit'

        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, Zip code can't be blank")
        expect(page).to have_button('Submit')
        expect(page).to have_current_path('/applications/new')
      end
    end
  end
end
