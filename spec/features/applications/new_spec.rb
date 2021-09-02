require 'rails_helper'

RSpec.describe 'applications new page' do
  before :each do
    visit new_application_path
  end

  describe 'new complete application' do
    it 'can make a new application' do
      fill_in 'Name', with: 'Tanner'
      fill_in 'Address', with: '1234 Street St.'
      fill_in 'City', with: 'Austin'
      fill_in 'State', with: 'Texas'
      fill_in 'Zipcode', with: '12345'
      click_button 'Submit Application'

      expect(current_path).to eq(application_path(Application.last.id))
    end
  end

  describe 'new incomplete application' do
    it 'rejects incomplete applications' do
      fill_in 'Name', with: 'Tanner'
      fill_in 'Address', with: '1234 Street St.'
      fill_in 'State', with: 'Texas'
      click_button 'Submit Application'

      expect(page).to have_content('Incomplete Application')
      expect(current_path).to eq(new_application_path)
      expect(Application.all.length).to eq(0)
    end
  end
end
