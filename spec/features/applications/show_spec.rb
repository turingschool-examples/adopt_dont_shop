require 'rails_helper'

RSpec.describe 'Applications' do
  context 'Show Page' do
    it 'will display an applications information' do
      @newapp = Application.create!({
        name: 'Chaz Simons',
        street_address: '1234 Cool Guy Rd',
        city: 'Las Vegas',
        state: 'NV',
        zip_code: 89106,
        good_fit: '',
        status: 'In Progress'
        })

        visit "/applications/#{@newapp.id}"

        expect(page).to have_content(@newapp.name)
        expect(page).to have_content(@newapp.street_address)
        expect(page).to have_content(@newapp.zip_code)
        expect(page).to have_content(@newapp.status)
    end
  end
end
