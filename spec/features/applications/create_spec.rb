require 'rails_helper'

RSpec.describe 'application creation' do
  before :each do
    @application_1 = Application.create!(name: 'Matt Wesley', street_address: '456 Orange RD', city: 'Sherbert', state: 'Oregon', zip_code: 97701)
    @application_2 = Application.create!(name: 'Annie Pulzone', street_address: '123 Lava LN', city: 'Pilot', state: 'Oregon', zip_code: 97703)
  end

  context 'application set up' do
    it 'has a welcome message' do
      visit '/applications/new'

      expect(page).to have_content('Fill out the form below')
    end

    it 'has a form to fill out' do
      visit '/applications/new'

      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end
end
