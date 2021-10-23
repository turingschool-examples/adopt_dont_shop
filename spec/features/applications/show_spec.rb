require 'rails_helper'

RSpec.describe 'Applications' do
  context 'Show Page' do
    before(:each) do
      @newapp = Application.create!({
        name: 'Chaz Simons',
        street_address: '1234 Cool Guy Rd',
        city: 'Las Vegas',
        state: 'NV',
        zip_code: 89106,
        good_fit: '',
        status: ''
        })
    end
    it 'will display an applications information' do
        visit "/applications/#{@newapp.id}"

        expect(page).to have_content(@newapp.name)
        expect(page).to have_content(@newapp.street_address)
        expect(page).to have_content(@newapp.zip_code)
        expect(page).to have_content(@newapp.status)
    end

    it 'can search for pets to add to an applicaiton' do
      visit "/applications/#{@newapp.id}"
      save_and_open_page
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Search")
    end
  end
end
