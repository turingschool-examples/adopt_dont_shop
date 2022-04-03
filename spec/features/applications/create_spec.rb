require 'rails_helper'

RSpec.describe 'application creation' do
  
  describe 'the application new' do
    it 'there is a form with fields' do
      visit "/applications/new"
save_and_open_page
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
      expect(find('form')).to have_button('Submit')
    end
  end
end 
