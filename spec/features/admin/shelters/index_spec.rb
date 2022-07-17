require 'rails_helper'

RSpec.describe 'Admin/shelters#index' do
  describe 'when I visit the admin shelters index page' do
    it 'shows me that I am on the admin shelters index page' do
      visit '/admin/shelters'
      expect(page).to have_content('All Shelters-Admin View')
    end
  end
end