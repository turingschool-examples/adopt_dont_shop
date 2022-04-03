require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'application new' do
    it 'renders the new form' do
      
      visit '/applications/new'

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('ZipCode')
      expect(find('form')).to have_content('Description')
      expect(find('form')).to have_content('Pending')
    end
  end
end
