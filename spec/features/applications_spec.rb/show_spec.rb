require 'rails_helper'

RSpec.describe 'applications show page', type: :feature do
  describe 'As a visitor' do
    before :each do
      @application = Application.create!(name: 'John', street_address: '1 Sesame St', city: 'Denver',
                    state: 'CO', zip_code: 12345, description: 'I like dogs', status: 'Pending')
    end

    it 'I can see the applications attributes' do
      visit "applications/#{@application.id}"
      expect(page).to have_content('John')
      expect(page).to have_content('1 Sesame St')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content(12345)
      expect(page).to have_content('I like dogs')
      expect(page).to have_content('Pending')
    end
  end
end