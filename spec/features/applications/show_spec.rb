require 'rails_helper'

RSpec.describe 'Applications' do
  context 'Show Page' do
    it 'will display an applications information' do
      @newapp = Application.create!({
        name: 'Chaz Simons',
        address: '1234 Cool Guy Rd, Las Vegas, NV 89106',
        good_fit: '',
        status: 'In Progress'
        })

        visit "/applications/#{@newapp.id}"
        expect(page).to have_content(@newapp.name)
    end
  end
end
