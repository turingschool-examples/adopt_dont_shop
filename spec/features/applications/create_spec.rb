require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it 'renders the new form' do
      visit '/applications/new'
      # save_and_open_page
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end
end