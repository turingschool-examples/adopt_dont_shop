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

    it 'renders a new form' do
      visit '/applications/new'

      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
      save_and_open_page
    end
  end

  context 'the application create' do
    describe 'give vaild data' do
      it 'creates the application and redirects to the applicaiton show page' do
        visit '/applications/new'

        fill_in 'Name', with: "#{@application_1.name}"
        fill_in 'Name', with: "#{@application_1.street_address}"
        fill_in 'Name', with: "#{@application_1.city}"
        fill_in 'Name', with: "#{@application_1.state}"
        fill_in 'Name', with: "#{@application_1.zip_code}"
        click_button 'Save'
      end
    end

    describe 'given invalid data'
      it 're-renders the new form'
  end
end
